module ApplicationHelper
  include Pagy::Frontend

  def current_path(path)
    'current' if current_page?(path)
  end

  def active_path(path)
    'active' if current_page?(path)
  end
end
