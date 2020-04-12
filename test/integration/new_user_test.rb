require 'test_helper'

class NewUserTest < ActionDispatch::IntegrationTest
  fixtures :all

  def setup
    @user = users(:random) 
  end
  
  test "invalid new user information" do
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { first_name: "",
                                         last_name: "",
                                         email: "user@invalid",
                                         is_admin: "" } }
    end
    assert_template '/users'
    assert_select 'div#error_explanation'
    assert_select 'div.alert.alert-danger'
  end
end
