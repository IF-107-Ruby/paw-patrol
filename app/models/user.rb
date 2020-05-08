# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  first_name             :string
#  last_name              :string
#  email                  :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  is_admin               :boolean          default(FALSE), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#
class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :registerable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one :users_companies_relationship, dependent: :destroy
  has_one :company, through: :users_companies_relationship

  validates :first_name, presence: true, length: { in: 2..50 }
  validates :last_name, presence: true, length: { in: 2..50 }
  validates :email, presence: true, length: { in: 8..255 },
                    format: { with: VALID_EMAIL_REGEX }

  def role
    users_companies_relationship.role if company.present?
  end

  def company_owner?
    role == 'company_owner'
  end

  before_create do
    skip_confirmation!
    SendConfirmationInstructionsJob.perform_later @user
  end  
end
