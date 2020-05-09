class AvailableUserUnitsQuery
  def initialize(user:)
    @user = user
  end

  def to_units_array
    @user.units.flat_map do |unit|
      family_units(unit).unshift(unit)
    end
  end

  private

  def family_units(unit)
    unit.ancestors + unit.descendants
  end
end
