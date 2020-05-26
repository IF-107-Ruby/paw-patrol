class Company
  UserUnitPolicy = Struct.new(:user, :unit) do
    def index?
      user.can_view_unit_dashboard?
    end

    def show?
      user.can_view_unit_dashboard?
    end
  end
end
