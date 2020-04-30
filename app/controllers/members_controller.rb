class MembersController < ApplicationController
  before_action :authenticate_user!

  def index
    @pagy, @members = pagy_decorated(current_company.members, items: 10)
  end
end
