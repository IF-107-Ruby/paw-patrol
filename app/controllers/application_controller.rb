class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  helper_method :current_company

  def current_user
    (super || Guest.new).decorate
  end

  def user_signed_in?
    !current_user.is_a?(Guest)
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
    @current_company ||= current_user.company
  end

  def after_sign_in_path_for(resource)
    dashboard_path = resource.admin? ? admin_dashboard_path : root_path
    stored_location_for(resource) || dashboard_path
  end
end
