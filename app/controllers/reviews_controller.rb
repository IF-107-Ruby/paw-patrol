class ReviewsController < ApplicationController
  layout 'hireo_dashboard'

  def index
    @tickets = current_user.tickets
  end
end
