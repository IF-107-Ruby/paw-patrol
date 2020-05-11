module UsersHelper
  def user_role_string(user)
    user.admin? ? 'Admin' : user.role&.capitalize&.gsub('_', ' ')
  end

  def user_company_content(user)
    company_role_and_link(user) if user.company.present?
  end

  def user_company_role(user)
    if user.admin?
      'Admin'
    elsif user.company.present?
      "#{user_role_string(user)} at #{user.company.name}"
    end
  end

  def user_company_name(user)
    user.company.name if user.company.present?
  end

  private

  def link_to_user_company(user)
    link_to(user.company.name, user.company)
  end

  def company_role_at(user)
    content_tag(:span, "#{user_role_string(user)} at ")
  end

  def company_role_and_link(user)
    content_tag(:div,
                company_role_at(user) + link_to_user_company(user),
                class: 'company-role')
  end
end
