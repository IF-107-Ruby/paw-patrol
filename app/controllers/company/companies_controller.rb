class Company
  class CompaniesController < Company::BaseController
    before_action -> { authorize([:company, Company]) }

    breadcrumb 'Edit', :company_edit_path, only: %i[edit update]

    def update
      if current_company.update(company_params)
        flash[:success] = 'Company profile has been updated.'
        redirect_to company_path
      else
        render 'edit'
      end
    end

    private

    def company_params
      params.require(:company).permit(:name, :description, :email, :phone)
    end
  end
end
