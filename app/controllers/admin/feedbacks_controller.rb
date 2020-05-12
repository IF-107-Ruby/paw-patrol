module Admin
  class FeedbacksController < Admin::BaseController
    before_action :authenticate_user!
    before_action :find_feedback_by_id, only: %i[show destroy]

    def index
      authorize([:admin, Feedback])
      @pagy, @feedbacks = pagy_decorated(Feedback.all.ordered_by_created_at, items: 10)
    end

    def show; end

    def destroy
      @feedback.destroy
      flash[:success] = 'Feedback message deleted'
      redirect_to admin_feedbacks_path
    end

    private

    def find_feedback_by_id
      authorize([:admin, Feedback])
      @feedback = Feedback.find(params[:id]).decorate
    end

    def feedback_params
      params.require(:feedback).permit(:user_full_name, :email, :message)
    end
  end
end
