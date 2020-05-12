module Admin
  DashboardPolicy = Struct.new(:user, :dashboard) do
    def index?
      user.admin?
    end
  end
end
