class CompanyDashboard
  attr_accessor :company

  def initialize(company)
    @company = company
  end

  def fun_facts
    {
      employees_count: company.employees.count,
      responsible_users_count: company.responsible_users.count,
      last_week_tickets_count: last_week_tickets_count,
      open_tickets_count: company.tickets.open.count
    }
  end

  def last_week_tickets_count
    company.tickets
           .where('tickets.created_at >= ?', 1.week.ago).count
  end

  def recent_tickets
    company.tickets.most_recent.open.limit(10).includes(:user, :responsible_user, :unit)
  end

  def review_rates
    reviews = Review.where(ticket: company.tickets)

    (1..5).map do |rating|
      {
        name: "Rated #{rating}",
        amount: reviews.where(rating: rating).count
      }
    end
  end

  def stats
    { recent_tickets: recent_tickets,
      fun_facts: fun_facts,
      review_rates: review_rates }
  end
end
