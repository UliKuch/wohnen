class FlatsNotifier
  attr_reader :flats
  attr_accessor :notifications_sent

  def initialize(flats:)
    @flats = flats
    @notifications_sent = 0
  end

  def notify_about_new_flats
    flats.each do |flat|
      next if flat.notified_at.present?
      notify_about(flat)
      @notifications_sent += 1
    end
  end

  private

  def notify_about(flat)
    message = FlatFormatter.new(flat: flat).format_for_chat

    if TelegramSender.new(message: message).send_to_chat
      flat.update_column(:notified_at, Time.zone.now)
    end
  end
end
