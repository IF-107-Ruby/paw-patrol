class MembersController < ApplicationController
  before_action :find_company_by_id, only: :index

  def index
    @company_name = @company.name
    @pagy, @members = pagy_decorated(@company.members, items: 10)
  end

  private

  def find_company_by_id
    @company = Company.where(id: params[:company_id]).first
    render 'errors/not_found' unless @company
  end
end
