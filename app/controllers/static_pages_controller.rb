class StaticPagesController < ApplicationController
  def contact
    @feedback = Feedback.new
  end
end
