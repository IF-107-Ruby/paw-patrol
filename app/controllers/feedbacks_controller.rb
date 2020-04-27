class FeedbacksController < ApplicationController
  before_action :authenticate_user!,  only: %i[index show destroy]
  before_action :find_feedback_by_id, only: %i[show destroy]

  def index
    @pagy, @feedbacks = pagy(authorize(Feedback.all.ordered_by_created_at), items: 10)
  end

  def show; end

  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      flash[:success] = 'Feedback sent'
      redirect_to root_path
    else
      flash.now[:warning] = 'Feedback is not sent!'
      render 'static_pages/contact'
    end
  end

  def destroy
    @feedback.destroy
    flash[:success] = 'Feedback message deleted'
    redirect_to feedbacks_path
  end

  private

  def find_feedback_by_id
    @feedback = authorize(Feedback.find(params[:id]))
  end

  def feedback_params
    params.require(:feedback).permit(:user_full_name, :email, :message)
  end
end
