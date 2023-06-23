require "rails_helper"

RSpec.describe TelegramSender do
  describe "#send_to_chat" do
    subject { described_class.new(message: "Some string") }

    let(:telegram_response) { FactoryBot.create(:telegram_response) }

    context "without 200 response status" do
      before do
        stub_request(:post, /https:\/\/api\.telegram\.org\/bot/)
          .to_return(status: 200, body: telegram_response)
      end

      it "returns formatted response body" do
        expect(subject.send_to_chat).to eq(JSON.parse(telegram_response))
      end

      it "does not raise error" do
        expect { subject.send_to_chat }.not_to raise_error
      end
    end

    context "with other response status" do
      before do
        stub_request(:post, /https:\/\/api\.telegram\.org\/bot/)
          .to_return(status: 500, body: telegram_response)
      end

      it "returns false" do
        expect(subject.send_to_chat).to eq(false)
      end

      it "does not raise error" do
        expect { subject.send_to_chat }.not_to raise_error
      end
    end
  end
end
