class CommentsController < ApplicationController
  before_action :find_commentable

  def new
    @comment = @commentable.comments.build(parent_id: params[:parent_id])
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.js do
          render template: 'shared/comments/create'
        end  
      end
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
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

  def find_commentable
    # @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = current_company
  end
end

 
