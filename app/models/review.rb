# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  rating     :integer          not null
#  comment    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Review < ApplicationRecord
  validates :rating, presence: true,
                     numericality: { only_integer: true },
                     inclusion: { in: 1..5 }
  validates :comment, presence: true, length: { maximum: 255 }
end
