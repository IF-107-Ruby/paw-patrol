class Company
  module BaseHelper
    def active_submenu(*controllers_names)
      'active-submenu' if controllers_names.include?(controller.controller_name)
    end
  end
end
