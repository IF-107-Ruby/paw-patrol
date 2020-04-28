class MembersController < ApplicationController
  before_action :authenticate_user!
  before_action :current_company, only: :index

  def index
    @company_name = @current_company.name
    @pagy, @members = pagy_decorated(@current_company.members, items: 10)
  end
end
