class ReadSatisfaction
  def self.call(*args, &block)
    new(*args, &block).execute
  end

  def initialize(current_company)
    @current_company = current_company
    @satisfaction = []
  end

  def execute
    (1..5).each do |rating|
      @satisfaction.push(get_amount_of_satisfaction_by_rating(rating))
    end
    @satisfaction
  end

  private

  def get_amount_of_satisfaction_by_rating(rating)
    {
      name: "Rated #{rating}",
      amount: Review.where(rating: rating, ticket: @current_company.tickets).count
    }
  end
end
