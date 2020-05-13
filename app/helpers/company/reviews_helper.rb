class Company
  module ReviewsHelper
    def ticket_reviewable_status
      content_tag(:span, 'Not Rated',
                  class: 'company-not-rated margin-bottom-5')
    end

    def review_action_link(ticket)
      link_to(new_company_ticket_review_path(ticket.id),
              class: 'button ripple-effect margin-top-5 margin-bottom-10') do
        content_tag(:i, ' ',
                    class: 'icon-material-outline-thumb-up') + ' Leave a Review'
      end
    end
  end
end
