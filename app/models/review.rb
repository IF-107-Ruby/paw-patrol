# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  rating     :integer          not null
#  comment    :text             not null
#  ticket_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Review < ApplicationRecord
  belongs_to :ticket

  validates :ticket, uniqueness: true
  validates :rating, presence: true,
                     numericality: { only_integer: true },
                     inclusion: { in: 1..5 }
  validates :comment, presence: true, length: { maximum: 255 }
  validate :ticket_decision_status

  after_commit :notify_review_changed, if: :saved_change_to_rating?

  private

  def ticket_decision_status
    return if ticket.resolved?

    errors.add(:ticket, 'ticket must be resolved')
  end

  def notify_review_changed
    NotificateReviewChangedJob.perform_later(self)
  end
end
