class Company
  UserUnitPolicy = Struct.new(:user, :unit) do
    def index?
      user.employee?
    end

    def show?
      user.employee?
    end

    def events?
      false
    end
  end
end
