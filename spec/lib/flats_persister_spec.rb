require "rails_helper"

RSpec.describe FlatsPersister do
  describe "#create_or_update_flats" do
    subject { described_class.new(flats_data: formatted_flats_data) }
    let!(:old_flat) { FactoryBot.create(:flat) }
    let(:formatted_flats_data) {
      FactoryBot.create(
        :formatted_flats_data,
        first_external_id: old_flat.external_id
      )
    }

    it "creates new flat for previously unpersisted flats only" do
      expect { subject.create_or_update_flats }
        .to change { Flat.count }.by(1)
      expect(subject.flats.count).to eq(2)
    end

    context "without flats data" do
      let(:formatted_flats_data) { nil }
      it "does not raise error" do
        expect { subject.create_or_update_flats }
          .not_to raise_error
      end
    end
  end
end
