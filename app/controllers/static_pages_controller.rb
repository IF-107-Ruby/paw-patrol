class StaticPagesController < ApplicationController
  def about; end

  def services; end

  def contact
    @feedback = Feedback.new
  end
end
