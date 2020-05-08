class AvailableUserUnitsQuery
  def initialize(user:)
    @user = user
    @units = []
  end

  def to_units_array
    @user.units.each do |unit|
      @units << unit
      read_unit_ancestors_to_units(unit)
    end
    @units
  end

  private

  def read_unit_ancestors_to_units(unit)
    @units = @units.union(Unit.ancestors_of(unit).order(id: :desc).to_a)
  end
end
