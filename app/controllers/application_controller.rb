class ApplicationController < ActionController::Base
  include Pagy::Backend

  private

  def pagy_decorated(*args)
    pagy_obj, members = pagy(*args)
    [pagy_obj, members.decorate]
  end
end
