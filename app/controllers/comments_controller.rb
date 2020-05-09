class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :check_permission
  before_action :authenticate_user!
  before_action :set_comment, only: [:destroy]

  def new
    @comment = authorize(@commentable.comments.build(parent_id: params[:parent_id]))
  end

  def create
    @comment = authorize(@commentable.comments.build(comment_params))
    @comment.user = current_user
    @comment.save
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
        render template: 'shared/comments/destroy'
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

  def set_comment
    @comment = authorize(current_user.comments.find(params[:id]))
  end

  def set_commentable
    @commentable = find_commentable
  end

  def find_commentable
    Ticket.find(params[:ticket_id]) if params[:ticket_id]
  end

  def check_parmission 
    @ticket = Ticket.find(params[:ticket_id])
  end
end
