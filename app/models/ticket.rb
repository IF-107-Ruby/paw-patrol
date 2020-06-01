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
  scope :most_recent, -> { order(created_at: :desc) }
  scope :resolved, -> { where(status: :resolved) }

  enum status: { open: 0, resolved: 1 }

  belongs_to :user
  belongs_to :unit

  has_one :review, dependent: :destroy
  has_one :ticket_completion, dependent: :destroy
  has_many :employees, through: :unit, class_name: 'User'
  has_many :events, dependent: :nullify
  has_many :comments,
           as: :commentable,
           dependent: :destroy,
           after_add: :send_new_comment_email
  has_many :watchers_relationship, dependent: :destroy
  has_many :watchers, through: :watchers_relationship, source: :user
  accepts_nested_attributes_for :watchers_relationship, allow_destroy: true

  has_rich_text :description
  has_rich_text :resolution

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

  after_create :add_author_to_watchers
  after_create :send_ticket_notification
  after_update :send_ticket_resolved_email

  has_ancestry

  def description_attachments
    description.body.attachments
  end

  def resolution_attachments
    resolution&.body&.attachments
  end

  def participants
    watchers + [unit.responsible_user]
  end

  def belongs_to?(current_user)
    user == current_user
  end

  def reviewed?
    review.present?
  end

  def available_watchers
    employees.decorate - [user]
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
    Ticket.create(follow_up_params)
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

  def follow_up_params
    attributes
      .except('id', 'status')
      .merge(description: description, parent: self)
  end

  def add_author_to_watchers
    watchers << user
  end

  def send_ticket_resolved_email
    return unless status_previously_changed? && resolved?

    SendTicketResolvedEmailJob.perform_later(id)
  end

  def send_new_comment_email(_)
    SendTicketHasCommentEmailJob.perform_later(id)
  end
end
