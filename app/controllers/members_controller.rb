class MembersController < ApplicationController
  before_action :find_company_by_id, only: :index

  def index
    @company_name = @company.name
    @members = @company.users.decorate
  end

  private

  def find_company_by_id
    @company = Company.find(params[:company_id])
  end
end
