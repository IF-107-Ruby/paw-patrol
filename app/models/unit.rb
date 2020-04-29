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
  validates :name, presence: true
  validates :company, presence: true
  has_ancestry
end
