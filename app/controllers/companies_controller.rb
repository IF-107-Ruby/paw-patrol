class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def show
    @company = load_company
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      flash[:success] = 'Company created.'
      redirect_to @company
    else
      render 'new'
    end
  end

  def edit
    @company = load_company
  end

  def update
    @company = load_company
    if @company.update_attributes(company_params)
      flash[:success] = 'Company profile updated.'
      redirect_to @company
    else
      render 'edit'
    end
  end

  def destroy
    load_company.destroy
    redirect_to [:companies]
  end

  private

  def company_params
    params.require(:company).permit(:name, :description, :email, :phone)
  end

  def load_company
    Company.find(params[:id])
  end
end
