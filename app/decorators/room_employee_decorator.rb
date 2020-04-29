class RoomEmployeeDecorator < Draper::Decorator
  delegate_all

  def full_name
    [first_name, last_name].join(' ').strip
    #"#{user.first_name} #{user.last_name}"
  end

end
