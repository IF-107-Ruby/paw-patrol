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
#
class Ticket < ApplicationRecord
  after_create :send_ticket_notification

  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user
  belongs_to :unit

  has_rich_text :description

  validates :user, :unit, :description, presence: true
  validates :name, presence: true, length: { in: 6..50 }

  validate :unit_permission, if: ->(ticket) { ticket.user }

  validates_with ImageAttachmentsValidator,
                 if: ->(ticket) { ticket.description_attachments.any? }

  scope :most_recent, -> { order(created_at: :desc) }

  def description_attachments
    description.body.attachments
  end

  def belongs_to?(current_user)
    user == current_user
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
