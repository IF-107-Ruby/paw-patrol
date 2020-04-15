class ErrorsController < ApplicationController
  def not_found
    render status: :not_found
  end

  def server_errors
    render status: :internal_server_error
  end
end
