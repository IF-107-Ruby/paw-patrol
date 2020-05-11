class CommentsController < ApplicationController
  before_action :commentable
  before_action :authenticate_user!

  def new
    @comment = authorize(@commentable.comments.build(parent_id: params[:parent_id]))
  end

  def create
    @comment = authorize(@commentable.comments.build(comment_params))
    @comment.save
    respond_to do |format|
      format.js do
        render template: 'shared/comments/create'
      end
    end
  end

  def destroy
    @comment = authorize(current_user.comments.find(params[:id]))
    @comment.destroy
    respond_to do |format|
      format.js do
        render template: 'shared/comments/destroy'
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id).merge(user_id: current_user.id)
  end

  def commentable
    @commentable ||= Ticket.find(params[:ticket_id])
  end
end
