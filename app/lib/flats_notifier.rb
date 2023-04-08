class FlatsNotifier
  attr_reader :flats

  def initialize(flats:)
    @flats = flats
  end

  def notify_about_new_flats
    flats.each do |flat|
      notify_about(flat) if flat.notified_at.blank?
    end
  end

  private

  def notify_about(flat)
    message = FormatFlatForChat.format(flat)

    if SendToTelegram.send_to_chat(message: message)
      flat.update_column(:notified_at, Time.zone.now)
    end
  end
end
