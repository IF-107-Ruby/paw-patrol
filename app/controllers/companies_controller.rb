class CompaniesController < ApplicationController
  breadcrumb 'Sign up', :sign_up_path, only: %i[new create]

  def new
    @company_registration = CompanyRegistrationsForm.new
  end

  def create
    @company_registration = CompanyRegistrationsForm.new(company_registration_params)

    if @company_registration.save
      flash[:success] = 'Company has been created.'
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def company_registration_params
    params
      .require(:company_registrations_form)
      .permit(:name, :description, :email,
              :phone, :first_name, :last_name,
              :user_email, :password, :password_confirmation)
  end
end
