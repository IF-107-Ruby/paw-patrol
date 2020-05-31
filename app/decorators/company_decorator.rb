class CompanyDecorator < Draper::Decorator
  delegate_all
  decorates_association :employees
  decorates_association :staff

  def users_count
    h.pluralize(users.count, 'member')
  end
end
