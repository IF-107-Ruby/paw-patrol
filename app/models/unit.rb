# == Schema Information
#
# Table name: units
#
#  id                  :bigint           not null, primary key
#  name                :string           not null
#  qr_link             :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  company_id          :bigint
#  ancestry            :string
#  responsible_user_id :integer
#
class Unit < ApplicationRecord
  scope :roots, -> { where(ancestry: nil) }
  scope :with_responsible, ->(user) { where(responsible_user_id: user.id) }

  belongs_to :company
  belongs_to :responsible_user, class_name: 'User', foreign_key: :responsible_user_id,
                                optional: true, inverse_of: :units

  has_many :tickets, dependent: :destroy
  has_many :users_units_relationships, dependent: :destroy
  has_many :users, through: :users_units_relationships
  has_many :employees, -> { employees },
           source: :user, through: :users_units_relationships
  has_many :events, dependent: :destroy

  accepts_nested_attributes_for :users_units_relationships, allow_destroy: true

  validates :name, presence: true
  validates :company, presence: true

  has_ancestry
end
