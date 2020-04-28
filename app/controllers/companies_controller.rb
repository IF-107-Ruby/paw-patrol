class CompaniesController < ApplicationController
  before_action :authenticate_user!, except: %i[new create]
  before_action :load_company, only: %i[show edit update destroy]

  def index
    @pagy, @companies = pagy(Company.all, items: 10)
  end

  def show; end

  def new
    @company_registration = CompanyRegistrationsForm.new
  end

  def create
    @company_registration = CompanyRegistrationsForm.new(company_registration_params)

    if (company = @company_registration.save)
      flash[:success] = 'Company has been created.'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @company.update(company_params)
      flash[:success] = 'Company profile has been updated.'
      redirect_to @company
    else
      render 'edit'
    end
  end

  def destroy
    @company.destroy
    flash[:success] = 'Company was deleted.'
    redirect_to [:companies]
  end

  private

  def company_params
    params.require(:company).permit(:name, :description, :email, :phone)
  end

  def company_registration_params
    params
      .require(:company_registrations_form)
      .permit(:name, :description, :company_email,
              :phone, :first_name, :last_name,
              :user_email, :password, :password_confirmation)
  end

  def load_company
    @company = Company.find(params[:id])
  end
end
