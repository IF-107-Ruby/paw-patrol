class CompanyDecorator < Draper::Decorator
  delegate_all

  def users_count
    h.pluralize(users.count, 'member')
  end
end
