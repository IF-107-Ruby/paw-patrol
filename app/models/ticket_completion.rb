class TicketCompletion < ApplicationRecord
  belongs_to :user
  belongs_to :ticket

  has_rich_text :description

  validates :user, :ticket, :description, presence: true

  validates_with ImageAttachmentsValidator,
                 if: ->(ticket) { ticket.description_attachments.any? }

  def description_attachments
    description.body.attachments
  end
end
