class CompanyDecorator < Draper::Decorator
  delegate_all

  def members_count
    h.pluralize(members.count, 'member')
  end
end
