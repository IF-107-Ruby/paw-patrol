class Company
  class ReviewsController < Company::BaseController
    def index
      @pagy, @tickets = pagy_decorated(current_user.tickets, items: 10)
    end

    def new
      @review = Review.new
    end

    def edit; end

    def create
      @review = Review.create(review_params)
      if @review.save
        flash[:success] = 'Review saved!'
        redirect_to company_reviews_path
      else
        flash.now[:warning] = 'Review is not saved!'
        render :new
      end
    end

    private

    def review_params
      params.require(:review).permit(:rating, :comment)
    end
  end
end
