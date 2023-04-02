class NotifyAboutNewFlats
  def self.notify
    new.notify
  end

  def notify
    Flat.where(notified_at: nil).find_each do |flat|
      notify_about(flat)
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
