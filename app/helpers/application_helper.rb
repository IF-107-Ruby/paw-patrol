module ApplicationHelper
  include Pagy::Frontend

  def request_path_components
    request.path.split('/')[1..-1]
  end

  def current_path(path)
    'current' if current_page?(path)
  end

  def active_path(path)
    'active' if current_page?(path)
  end
end
