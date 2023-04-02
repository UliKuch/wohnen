class SendToTelegram
  SEND_MESSAGE_URL = "https://api.telegram.org/bot#{ENV["TELEGRAM_BOT_TOKEN"]}/sendMessage"

  def self.send_to_chat(message:)
    new.send_to_chat(message: message)
  end

  def initialize
  end
  
  def send_to_chat(message:)
    uri = URI.parse(SEND_MESSAGE_URL)
    body = {
      chat_id: ENV["TELEGRAM_CHAT_ID"],
      text: message
    }.to_json
    headers = {
      "Content-Type"=>"application/json"
    }

    res = Faraday.post(uri, body, headers)

    if res.status == 200
      JSON.parse(res.body)
    else
      false
    end
  end
end
