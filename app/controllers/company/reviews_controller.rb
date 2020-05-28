class Company
  class ReviewsController < Company::BaseController
    before_action :find_reviewable_ticket_by_id
    before_action :find_review_by_ticket, only: %i[show edit update]

    def show; end

    def new
      @review = @ticket.build_review
      authorize([:company, @review])
    end

    def edit; end

    def create
      @review = @ticket.build_review(review_params)
      authorize([:company, @review])
      if @review.save
        flash[:success] = 'Review saved!'
        redirect_to resolved_company_tickets_path
      else
        flash.now[:warning] = 'Review is not saved!'
        render :new
      end
    end

    def update
      if @review.update(review_params)
        flash[:success] = 'Review updated!'
        redirect_to resolved_company_tickets_path
      else
        flash.now[:warning] = 'Review is not updated!'
        render :edit
      end
    end

    private

    def find_reviewable_ticket_by_id
      @ticket = current_company.resolved_tickets.find(params[:ticket_id])
    end

    def find_review_by_ticket
      @review = @ticket.review.decorate
      authorize([:company, @review])
    end

    def review_params
      params.require(:review).permit(:rating, :comment)
    end
  end
end
