class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def current_user
    super || Guest.new
  end

  private

  def pagy_decorated(*args)
    pagy_obj, members = pagy(*args)
    [pagy_obj, members.decorate]
  end

  def user_not_authorized
    flash[:warning] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end

  def record_not_found
    render 'errors/not_found'
  end

  def current_company
    @current_company = current_user.company if current_user
  end
end
