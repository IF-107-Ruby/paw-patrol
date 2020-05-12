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
  belongs_to :company
  has_many :tickets, dependent: :destroy
  has_many :users_units_relationships, dependent: :destroy
  has_many :users, through: :users_units_relationships
  belongs_to :responsible_user, class_name: 'User', foreign_key: :responsible_user_id,
                                optional: true, inverse_of: :units
  validates :name, presence: true
  validates :company, presence: true
  has_ancestry
end
