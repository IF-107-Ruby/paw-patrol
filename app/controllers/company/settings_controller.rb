class Company
  class SettingsController < Company::BaseController
    breadcrumb 'Settings', %i[company settings], match: :exclusive
  end
end
