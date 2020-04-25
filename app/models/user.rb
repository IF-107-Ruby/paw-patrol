class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :registerable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  has_one :users_companies_relationship, dependent: :destroy
  has_one :company, through: :users_companies_relationship

  validates :first_name, presence: true, length: { in: 2..50 }
  validates :last_name, presence: true, length: { in: 2..50 }
  validates :email, presence: true, length: { in: 8..255 },
                    format: { with: VALID_EMAIL_REGEX }

  def role
    users_companies_relationship.role if company.present?
  end
end
