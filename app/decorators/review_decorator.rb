class ReviewDecorator < Draper::Decorator
  delegate_all

  def month_of_reviewable
    created_at.strftime('%B %Y')
  end
end
