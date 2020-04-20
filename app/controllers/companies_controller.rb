class CompaniesController < ApplicationController
  before_action :load_company, only: %i[show edit update destroy]

  def index
    @pagy, @companies = pagy(Company.all, items: 10)
  end

  def show; end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      flash[:success] = 'Company has been created.'
      redirect_to @company
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

  def load_company
    @company = Company.find(params[:id])
  end
end
