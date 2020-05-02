class Admin::FeedbacksController < ApplicationController
  layout 'hireo', only: %i[new create]
  before_action :authenticate_user!,  only: %i[index show destroy]
  before_action :find_feedback_by_id, only: %i[show destroy]

  def index
    @pagy, @feedbacks = pagy(authorize(Feedback.all.ordered_by_created_at), items: 10)
  end

  def show; end

  def destroy
    @feedback.destroy
    flash[:success] = 'Feedback message deleted'
    redirect_to admin_feedbacks_path
  end

  private

  def find_feedback_by_id
    @feedback = authorize(Feedback.find(params[:id]))
  end

  def feedback_params
    params.require(:feedback).permit(:user_full_name, :email, :message)
  end
end
