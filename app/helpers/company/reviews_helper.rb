class Company
  module ReviewsHelper
    def ticket_reviewable_status(ticket:)
      if ticket.was_reviewable?
        review = ticket.review
        link_to(company_review_path(review), class: 'review-link') do
          reviewable_content(review: review)
        end
      else
        content_tag(:span, 'Not Rated',
                    class: 'company-not-rated margin-bottom-5')
      end
    end

    def reviewable_content(review:)
      content_tag(:div,
                  class: 'item-details margin-top-10') do
        content_tag(:div, '&nbsp;'.html_safe,
                    'data-rating' => review.rating,
                    class: 'star-rating') +
          content_tag(:div, content_tag(:i,
                                        " #{review.month_of_reviewable}",
                                        class: 'icon-material-outline-date-range'),
                      class: 'detail-material-outline-date-range')
      end
    end

    def review_action_link(ticket:)
      if ticket.was_reviewable?
        update_review_link(review: ticket.review)
      else
        create_review_link(ticket_id: ticket.id)
      end
    end

    def create_review_link(ticket_id:)
      link_to(new_company_review_path(ticket_id: ticket_id),
              class: 'button ripple-effect margin-top-5 margin-bottom-10') do
        content_tag(:i, ' ',
                    class: 'icon-material-outline-thumb-up') + ' Leave a Review'
      end
    end

    def update_review_link(review:)
      link_to(edit_company_review_path(review),
              class: 'button gray ripple-effect margin-top-5 margin-bottom-10') do
        content_tag(:i, ' ',
                    class: 'icon-feather-edit') + ' Edit Review'
      end
    end
  end
end
