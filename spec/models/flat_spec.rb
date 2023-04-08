require "rails_helper"

RSpec.describe Flat, type: :model do
  describe "#google_maps_link" do
    let!(:flat) { FactoryBot.create(:flat) }

    context "with address given" do
      it "returns google maps link" do
        expect(flat.google_maps_link)
          .to eq("https://www.google.de/maps/place/Beispielstr.+60,+Spitzenstadtteil")
      end
    end

    context "without address" do
      before do
        flat.update_column(:attr, flat.attr.merge({"Adresse" => nil}))
      end

      it "returns nil" do
        expect(flat.google_maps_link).to be_nil
      end
    end
  end
end
