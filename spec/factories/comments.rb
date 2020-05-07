FactoryBot.define do
  factory :comment do
    commentable_id { 1 }
    commentable_type { 'Ticket' }
    user_id { 1 }
    body { 'MyText' }
  end
end
