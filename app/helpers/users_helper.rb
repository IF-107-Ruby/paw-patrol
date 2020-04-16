module UsersHelper
  def user_company_content(user)
    company_role_and_link(user) if user.company.present?
  end

  private

  def link_to_user_company(user)
    link_to(user.company.name, user.company)
  end

  def company_role_at(user)
    content_tag(:span,
                "#{user.users_companies_relationship.role.capitalize} at")
  end

  def company_role_and_link(user)
    company_role_at(user) + link_to_user_company(user)
  end
end
