namespace :telegram do
  namespace :bot do
    desc 'Telegram bot'
    task start: :environment do
      ruby File.expand_path('../../telegram/bot.rb', __dir__)
    end
  end
end
