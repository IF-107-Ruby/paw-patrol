class UserUnitRelation < ApplicationRecord
  belongs_to :users_units_relationship
  belongs_to :unit
end
