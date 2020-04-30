# == Schema Information
#
# Table name: units
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  qr_link    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint
#  ancestry   :string
#
class Unit < ApplicationRecord
  belongs_to :company
  has_many :users_units_relationships, dependent: :destroy
  has_many :users, through: :users_units_relationships
  validates :name, presence: true
  validates :company, presence: true
  has_ancestry
end
