class Company
  UserUnitPolicy = Struct.new(:user, :unit) do
    def index?
      user.employee?
    end

    def show?
      user.employee?
    end
  end
end
