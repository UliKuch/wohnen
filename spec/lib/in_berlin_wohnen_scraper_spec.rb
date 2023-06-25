require "rails_helper"

RSpec.describe InBerlinWohnenScraper do
  describe "#scrape" do
    subject { described_class.new }
    let(:first_external_id) { "flat_2233445" }
    let(:second_external_id) { "flat_5566778" }
    let(:raw_flats_data) {
      FactoryBot.create(
        :raw_flats_data,
        first_external_id: first_external_id,
        second_external_id: second_external_id
      )
    }
    let(:formatted_flats_data) {
      FactoryBot.create(
        :formatted_flats_data,
        first_external_id: first_external_id,
        second_external_id: second_external_id
      )
    }

    context "with data present" do
      before do
        stub_request(:get, /https:\/\/inberlinwohnen\.de\/wohnungsfinder/)
          .to_return(status: 200, body: raw_flats_data)
      end

      it "formats flat data" do
        subject.scrape
        expect(subject.flats_data).to eq(formatted_flats_data)
      end
    end

    context "without data present" do
      before do
        stub_request(:get, /https:\/\/inberlinwohnen\.de\/wohnungsfinder/)
          .to_return(status: 200, body: nil)
      end

      it "returns empty array" do
        subject.scrape
        expect(subject.flats_data).to eq([])
      end

      it "does not raise error" do
        expect { subject.scrape }.not_to raise_error
      end
    end
  end
end
