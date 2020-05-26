class Company
  module ReviewsHelper
    def ticket_reviewable_status(ticket)
      if ticket.reviewed?
        review = ticket.review
        link_to(company_review_path(review), class: 'review-link') do
          render('company/reviews/reviewable_content', review: review)
        end
      else
        content_tag(:span, 'Not Rated',
                    class: 'company-not-rated margin-bottom-5')
      end
    end
  end
end
