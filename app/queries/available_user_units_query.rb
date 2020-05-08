class AvailableUserUnitsQuery
  def initialize(user:)
    @user = user
    @units = []
  end

  def to_units_array
    user_units = Company.first.units
    user_units.each do |unit|
      units << unit
      read_unit_ancestors(unit)
    end
    units
  end

  private

  attr_reader :user, :units

  def read_unit_ancestors(unit)
    Unit.ancestors_of(unit).order(id: :desc).each do |parent|
      units << parent
    end
  end
end
