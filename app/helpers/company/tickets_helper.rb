class Company
  module TicketsHelper
    def ticket_reviewable_status(ticket)
      if ticket.reviewed?
        review = ticket.review
        link_to(company_ticket_review_path(ticket), class: 'review-link') do
          render('company/shared/reviewable_content', review: review)
        end
      else
        content_tag(:span, 'Not Rated',
                    class: 'company-not-rated margin-bottom-5')
      end
    end
  end
end
