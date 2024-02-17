require 'line/bot'

Rails.application.config.line_bot_client = Line::Bot::Client.new { |config|
  config.channel_secret = Rails.application.credentials.dig(:line_bot, :channel_secret)
  config.channel_token = Rails.application.credentials.dig(:line_bot, :channel_token)
}