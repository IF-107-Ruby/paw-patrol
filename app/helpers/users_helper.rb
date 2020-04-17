module UsersHelper
  def full_user_name(user)
    user.first_name + ' ' + user.last_name
  end

  def user_role_string(user)
    user.role.capitalize.gsub('_', ' ')
  end

  def user_company_content(user)
    company_role_and_link(user) if user.company.present?
  end

  private

  def link_to_user_company(user)
    link_to(user.company.name, user.company)
  end

  def company_role_at(user)
    content_tag(:span, "#{user_role_string(user)} at")
  end

  def company_role_and_link(user)
    content_tag(:div,
                company_role_at(user) + link_to_user_company(user),
                class: 'company-role')
  end
end
