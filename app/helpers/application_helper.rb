module ApplicationHelper
  include Pagy::Frontend

  def current_path(path)
    'current' if current_page?(path)
  end

  def active_path(path)
    'active' if current_page?(path)
  end

  def footer_bottom_text
    "Copyright &copy; <b>Room Passport.SoftServe</b> #{Time.zone.now.strftime('%Y')}"
  end

  def small_footer_bottom_text
    "&copy; #{Time.zone.now.strftime('%Y')}" \
      ' <b>Room Passport.SoftServe</b>. All Rights Reserved.'
  end

  def user_avatar(user)
    user.avatar.attached? ? user.avatar : 'user-avatar-placeholder'
  end
end
