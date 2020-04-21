class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    [first_name, last_name].join(' ').strip
  end

  def self.collection_decorator_class
    PaginatingDecorator
  end
end
