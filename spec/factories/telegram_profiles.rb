FactoryBot.define do
  factory :telegram_profile do
    first_name { 'MyString' }
    last_name { 'MyString' }
    username { 'MyString' }
    language_code { 'MyString' }
    supports_inline_queries { false }
    user_id { 1 }
  end
end
