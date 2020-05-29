class ReviewDecorator < Draper::Decorator
  delegate_all

  def reviews_at_month
    created_at.strftime('%B %Y')
  end
end
