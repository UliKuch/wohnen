class TelegramSender
  SEND_MESSAGE_URL = "https://api.telegram.org/bot#{ENV["TELEGRAM_BOT_TOKEN"]}/sendMessage"

  attr_reader :message

  def initialize(message:)
    @message = message
  end

  def send_to_chat
    uri = URI.parse(SEND_MESSAGE_URL)
    body = {
      chat_id: ENV["TELEGRAM_CHAT_ID"],
      text: message
    }.to_json
    headers = {
      "Content-Type" => "application/json"
    }

    res = Faraday.post(uri, body, headers)

    if res.status == 200
      JSON.parse(res.body)
    else
      false
    end
  end
end
