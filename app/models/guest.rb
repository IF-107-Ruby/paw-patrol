class Guest < User
  def company_owner?
    false
  end

  def admin?
    false
  end

  def company?
    false
  end

  def decorate
    self
  end

  def company
    NullCompany.new
  end
end
