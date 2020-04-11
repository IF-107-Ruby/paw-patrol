class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.create(company_params)
    redirect_to @company
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(company_params)
      flash[:success] = 'Company profile updated'
      redirect_to @company
    else
      render 'edit'
    end
  end

  def destroy
    Company.find(params[:id]).destroy
    redirect_to [:companies]
  end

  private

  def company_params
    params.require(:company).permit(:name, :description, :email, :phone)
  end
end
