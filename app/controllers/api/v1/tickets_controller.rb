module Api
  module V1
    class TicketsController < Api::BaseController
      after_action :add_pagy_headers, only: :index
      def index
        respond_to do |format|
          format.json do
            @tickets = @company.tickets.with_rich_text_description.most_recent.open
            @pagy, @tickets = pagy_decorated(@tickets, items: 10)
          end
        end
      end
    end
  end
end
