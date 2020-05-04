class Guest
  def company_owner?
    false
  end

  def admin?
    false
  end

  def decorate
    self
  end
end
