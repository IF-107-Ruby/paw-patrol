class AvailableUserUnitsFindQuery
  def initialize(user:)
    @user = user
  end

  def to_units_array
    read_user_unit
    read_unit_ancestors
    array_with_units
  end

  private

  attr_reader :user, :user_unit, :unit_ancestors

  def read_user_unit
    # TODO
    @user_unit = user.unit
  end

  def read_unit_ancestors
    @unit_ancestors = Unit.ancestors_of(user_unit).order(id: :desc)
  end

  def array_with_units
    unit_ancestors.to_a.unshift(user_unit)
  end
end
