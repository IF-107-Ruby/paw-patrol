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
#  admin                  :boolean          default(FALSE), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#
class User < ApplicationRecord
  enum role: { company_owner: 0, employee: 1, staff_member: 2 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :registerable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  has_one :users_companies_relationship, dependent: :destroy
  has_one :company, through: :users_companies_relationship
  has_many :users_units_relationship, dependent: :destroy
  has_many :units, through: :users_units_relationship
  


  validates :first_name, :last_name,
            presence: true,
            length: { minimum: 2,
                      maximum: 50,
                      too_short: 'must have at least %<count>s characters',
                      too_long: 'must have at most %<count>s characters' }

  def company_owner?
    role == 'company_owner'
  end

  def self.grouped_collection_by_role
    {
      'admin' => User.where(admin: true),
      'company_owner' => User.where(role: 0),
      'employee' => User.where(role: 1),
      'staff_member' => User.where(role: 2)
    }
  end
end
