require "rails_helper"

RSpec.describe FlatsNotifier do
  describe "#notify_about_new_flats" do
    subject { described_class.new(flats: new_flats + old_flats) }
    let(:new_flats) { FactoryBot.create_list(:flat, 2) }
    let(:old_flats) { FactoryBot.create_list(:flat, 2, notified_at: 1.minute.ago) }

    before do
      allow_any_instance_of(TelegramSender).to receive(:send_to_chat)
        .and_return(true)
    end

    it "sets timestamps and correctly counts notifications for new flats only" do
      expect { subject.notify_about_new_flats }
        .to change { new_flats.first.reload.notified_at }
        .and change { new_flats.last.reload.notified_at }
        .and keep { old_flats.first.reload.notified_at }
        .and keep { old_flats.last.reload.notified_at }
      expect(subject.notifications_sent).to eq(2)
    end
  end
end
