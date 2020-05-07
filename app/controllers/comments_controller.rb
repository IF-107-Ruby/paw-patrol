class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :authenticate_user!
  before_action :set_comment, only: [:destroy]

  def new
    @comment = authorize(@commentable.comments.build(parent_id: params[:parent_id]))
  end

  def create
    @comment = authorize(@commentable.comments.build(comment_params))
    @comment.user = current_user
    Rails.logger.info("qqqqqqqqqqqqq #{@comment.user.inspect}")
    return unless @comment.save

    respond_to do |format|
      format.js do
        render template: 'shared/comments/create'
      end
    end
  end

  def destroy
    # @comment = authorize(@commentable.comments.find(params[:id]))
    @comment.destroy
    respond_to do |format|
      format.js do
        render template: 'shared/comments/create'
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def set_commentable
    @commentable = find_commentable
  end

  def find_commentable
    # Ticket.find(params[:ticket_id]) if params[:ticket_id]
    Company.find(params[:company_id]) if params[:company_id]
  end
end
