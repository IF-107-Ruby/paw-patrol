# == Schema Information
#
# Table name: tickets
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  user_id    :bigint           not null
#  unit_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer          default("open"), not null
#
class Ticket < ApplicationRecord
  enum status: { open: 0, resolved: 1 }

  after_create :send_ticket_notification

  belongs_to :user
  belongs_to :unit
  has_one :review, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  has_rich_text :description
  has_rich_text :resolution
  has_one :ticket_completion, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_ancestry

  validates :user, :unit, :description, presence: true
  validates :name, presence: true, length: { in: 6..50 }

  validate :unit_permission, if: ->(ticket) { ticket.user }

  validates_with ImageAttachmentsValidator,
                 if: ->(ticket) { ticket.description_attachments.any? }

  validates_with ImageAttachmentsValidator,
                 if: lambda { |ticket|
                   ticket.resolution_attachments &&
                     ticket.resolution_attachments.any?
                 }

  scope :most_recent, -> { order(created_at: :desc) }
  scope :resolved, -> { where(status: :resolved) }

  def description_attachments
    description.body.attachments
  end

  def resolution_attachments
    resolution&.body&.attachments
  end

  def belongs_to?(current_user)
    user == current_user
  end

  def reviewed?
    review.present?
  end

  def complete!(resolution)
    if resolution[:resolution].present?
      update(resolution)
      resolved!
    else
      errors.add(:ticket, 'completion must be not empty.')
      false
    end
  end

  def follow_up
    ticket = Ticket.new(attributes.except('id', 'status'))
    ticket.description = description
    ticket.parent = self
    ticket
  end

  private

  def unit_permission
    available_units = AvailableUserUnitsQuery.new(user: user).to_units_array
    return if available_units.include?(unit)

    errors.add(:unit, 'user is not allowed to create a ticket for this unit')
  end

  def send_ticket_notification
    SendNewTicketEmailJob.perform_later(id, unit.responsible_user.present?)
  end
end
