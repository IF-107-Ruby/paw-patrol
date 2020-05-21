class Company
  class ReviewsController < Company::BaseController
    before_action :find_review_by_id, only: %i[edit update]

    def index
      authorize([:company, Review])
      @pagy, @tickets = pagy_decorated(current_user.tickets, items: 10)
    end

    def new
      @review = Review.new(ticket_id: params[:ticket_id])
      authorize([:company, @review])
    end

    def edit; end

    def create
      @review = Review.create(review_params)
      authorize([:company, @review])
      if @review.save
        flash[:success] = 'Review saved!'
        redirect_to company_reviews_path
      else
        flash.now[:warning] = 'Review is not saved!'
        render :new
      end
    end

    def update
      if @review.update(review_params)
        flash[:success] = 'Review updated!'
        redirect_to company_reviews_path
      else
        flash.now[:warning] = 'Review is not updated!'
        render :edit
      end
    end

    private

    def find_review_by_id
      @review = Review.find(params[:id])
      authorize([:company, @review])
    end

    def review_params
      params.require(:review).permit(:rating, :comment, :ticket_id)
    end
  end
end
