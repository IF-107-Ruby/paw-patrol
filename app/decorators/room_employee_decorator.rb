class RoomEmployeeDecorator < Draper::Decorator
  delegate_all

  def full_name
    [first_name, last_name].join(' ').strip
  end

end
