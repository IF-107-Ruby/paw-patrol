class Company
  class UsersController < Company::BaseController
    before_action :obtain_user,       only: %i[show edit update destroy]
    before_action :load_user_tickets, only: :show

    breadcrumb 'Users', %i[company users], match: :exclusive
    breadcrumb -> { @user.full_name }, -> { [:company, @user] },
               match: :exclusive, only: %i[show edit update]
    breadcrumb 'New', %i[new company user], only: %i[new create]
    breadcrumb 'Edit', -> { [:edit, :company, @user] }, only: %i[edit update]

    def index
      authorize([:company, User])
      @pagy, @users = pagy_decorated(users_base_relation, items: 10)
    end

    def show; end

    def new
      @user = users_base_relation.build
      authorize([:company, @user])
    end

    def create
      @user = users_base_relation.build(user_params)
      authorize([:company, @user])

      if @user.save
        flash[:success] = 'Company member created.'
        redirect_to [:company, @user]
      else
        render 'new'
      end
    end

    def edit; end

    def update
      if @user.update(user_params)
        flash[:success] = 'User profile updated'
        redirect_to [:company, @user]
      else
        render 'edit'
      end
    end

    def destroy
      @user.destroy
      flash[:success] = 'Company member was deleted'
      redirect_to company_users_path
    end

    private

    def user_params
      params.require(:user).permit(:first_name,
                                   :last_name,
                                   :email,
                                   :password,
                                   :password_confirmation,
                                   :role)
    end

    def obtain_user
      @user = users_base_relation.find(params[:id]).decorate
      authorize([:company, @user])
    end

    def users_base_relation
      current_company.users
    end

    def paginate_user_tickets(tickets)
      @tickets_pagy, @user_tickets = pagy_decorated(tickets,
                                                    items: 5,
                                                    page_param: :page_tickets)
    end

    def load_user_tickets
      if @user.company_owner? || @user.employee?
        paginate_user_tickets(@user.tickets.most_recent)
      else
        paginate_user_tickets(@user.resolved_tickets.most_recent)
      end
    end
  end
end
