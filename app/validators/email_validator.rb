class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value =~ Devise.email_regexp

    record.errors[attribute] << (options[:message] || 'is not valid email')
  end
end
