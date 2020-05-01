class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    [first_name, last_name].join(' ').strip
  end

  def display_role
    if is_admin?
      'Admin'
    else
      role
    end
  end
end
