class NotificateReviewChangedJob < ApplicationJob
  queue_as :default

  attr_reader :review

  def perform(id)
    review = Review.find(id)

    ActionCable.server.broadcast(
      "company_dashboard:#{review.ticket.company.id}",
      { event: '@review_rates',
        data: ReadSatisfaction.call(review.ticket.company).as_json }
    )
  end
end
