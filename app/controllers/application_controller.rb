class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit

  layout 'hireo'

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  helper_method :current_company

  breadcrumb 'Home', :root_path

  def current_user
    (super || Guest.new).decorate
  end

  def user_signed_in?
    !current_user.is_a?(Guest)
  end

  impersonates :user,
               method: :current_user,
               with: ->(id) { User.find_by(id: id).decorate }

  private

  def pagy_decorated(*args)
    pagy_obj, members = pagy(*args)
    [pagy_obj, members.decorate]
  end

  def user_not_authorized
    respond_to do |format|
      format.html do
        flash[:warning] = 'You are not authorized to perform this action.'
        redirect_to(request.referer || root_path)
      end
      format.json { render json: 'Unauthorized action', status: :unauthorized }
    end
  end

  def record_not_found
    respond_to do |format|
      format.html do
        render 'errors/not_found'
      end
      format.json { render json: 'Not found', status: :not_found }
    end
  end

  def current_company
    @current_company ||= (current_user.company || NullCompany.new).decorate
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || resource.decorate.after_sign_in_path
  end
end
