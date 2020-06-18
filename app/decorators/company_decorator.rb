class CompanyDecorator < Draper::Decorator
  delegate_all
  decorates_association :employees
  decorates_association :staff

  def users_count
    h.pluralize(users.count, 'member')
  end

  def registration_date
    created_at.strftime('%F')
  end
end
