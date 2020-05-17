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
class Guest < User
  def company_owner?
    false
  end

  def admin?
    false
  end

  def company?
    false
  end

  def decorate
    self
  end

  def company
    NullCompany.new
  end
end
