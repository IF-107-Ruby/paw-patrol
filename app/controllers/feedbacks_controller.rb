class FeedbacksController < ApplicationController
  layout 'hireo', only: %i[new create]

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      flash[:success] = 'Feedback sent'
      redirect_to root_path
    else
      flash.now[:warning] = 'Feedback is not sent!'
      render :new
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:user_full_name, :email, :message)
  end
end
