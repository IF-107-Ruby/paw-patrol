module UsersHelper
  def show_company_link(user)
    link_to user.company.name, user.company if user.company.present?
  end
end
