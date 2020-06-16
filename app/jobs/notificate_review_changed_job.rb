class NotificateReviewChangedJob < ApplicationJob
  queue_as :default

  attr_reader :review

  def perform(id)
    review = Review.find(id)

    ActionCable.server.broadcast(
      "dashboards_#{review.ticket.company.id}_channel",
      { event: '@review_rates',
        data: ReadSatisfaction.call(review.ticket.company).as_json }
    )
  end
end
