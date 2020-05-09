class AvailableUserUnitsQuery
  def initialize(user:)
    @user = user
  end

  def to_units_array
    if @user.company_owner?
      @user.company.units
    else
      @user.units.flat_map do |unit|
        family_units(unit).unshift(unit)
      end
    end
  end

  private

  def family_units(unit)
    unit.ancestors + unit.descendants
  end
end
