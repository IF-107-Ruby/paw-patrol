class Company
  class CommentsController < Company::BaseController
    before_action :commentable

    def new
      @comment = @commentable.comments.build(parent_id: params[:parent_id])
      authorize([:company, @comment])
    end

    def create
      @comment = @commentable.comments.build(comment_params)
      authorize([:company, @comment])

      create_notification @commentable, @comment if @comment.save

      respond_to do |format|
        format.js
      end
    end

    def destroy
      @comment = current_user.comments.find(params[:id])
      authorize([:company, @comment])

      @comment.destroy
      respond_to do |format|
        format.js
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:body, :parent_id).merge(user_id: current_user.id)
    end

    def commentable
      @commentable ||= Ticket.find(params[:ticket_id])
    end

    def create_notification(commentable, comment)
      users_to_notify = [commentable.user, commentable.unit.responsible_user]
      # Add watchers

      users_to_notify.each do |user|
        next if user.id == current_user.id

        Notification.create(user: user,
                            notified_by: current_user,
                            noticeable: comment)
      end
    end
  end
end
