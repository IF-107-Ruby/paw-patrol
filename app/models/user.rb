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
#  role                   :integer          default("company_owner"), not null
#
class User < ApplicationRecord
  scope :admins, -> { where(admin: true) }
  scope :company_owners, -> { where(role: :company_owner) }
  scope :employees, -> { where(role: :employee) }
  scope :staff_members, -> { where(role: :staff_member) }
  scope :responsible_users, -> { joins(:assigned_units).distinct }

  enum role: { company_owner: 0, employee: 1, staff_member: 2 }

  has_one :users_companies_relationship, dependent: :destroy
  has_one :company, through: :users_companies_relationship
  has_one :telegram_profile, dependent: :nullify

  has_many :users_units_relationships, dependent: :destroy
  has_many :units, through: :users_units_relationships
  has_many :assigned_units, foreign_key: :responsible_user_id,
                            class_name: 'Unit', dependent: :nullify,
                            inverse_of: :responsible_user
  has_many :comments, dependent: :nullify
  has_many :notifications, dependent: :destroy
  has_many :events, dependent: :nullify
  has_many :tickets, dependent: :destroy
  has_many :assigned_tickets, through: :assigned_units,
                              source: :tickets

  validates :first_name, :last_name,
            presence: true,
            length: { minimum: 2,
                      maximum: 50,
                      too_short: 'must have at least %<count>s characters',
                      too_long: 'must have at most %<count>s characters' }

  after_create :send_invitation, unless: :company_owner?
  after_create :send_confirmation, if: :company_owner?

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable, :registerable
  devise :database_authenticatable, :confirmable,
         :recoverable, :rememberable, :validatable

  def responsible_for?(unit)
    id == unit.responsible_user_id
  end

  def self.grouped_collection_by_role
    {
      'admin' => User.admins,
      'company_owner' => User.company_owners,
      'employee' => User.employees,
      'staff_member' => User.staff_members
    }
  end

  def company?
    company.present?
  end

  def resolved_tickets?
    tickets.resolved.any?
  end

  def responsible?
    assigned_units.any?
  end

  def available_units
    if responsible?
      assigned_units
    else
      AvailableUserUnitsQuery.new(user: self).to_units_array
    end
  end

  def current_tickets
    tickets_scope(available_units).open
  end

  def resolved_tickets
    tickets_scope(available_units).resolved
  end

  def completion_performer?(completion)
    ticket_completions.include?(completion)
  end

  private

  def send_invitation
    skip_confirmation_notification!
    SendInvitationEmailJob.perform_later(id, password)
  end

  def send_confirmation
    skip_confirmation_notification!
    SendConfirmationInstructionsJob.perform_later(id)
  end

  def tickets_scope(units)
    Ticket.for_units(units)
  end
end
