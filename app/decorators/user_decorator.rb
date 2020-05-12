class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    [first_name, last_name].join(' ').strip
  end

  def display_role
    if admin?
      'Admin'
    else
      role.humanize.capitalize
    end
  end

  def after_sign_in_path
    admin? ? h.admin_dashboard_path : h.company_dashboard_path
  end

  def role_at_company
    "#{display_role} at #{company_name}"
  end

  delegate :name, to: :company, prefix: true
end
