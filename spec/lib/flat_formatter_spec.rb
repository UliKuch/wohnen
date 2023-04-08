require "rails_helper"

RSpec.describe FlatFormatter do
  describe "#format_for_chat" do
    subject { described_class.new(flat: flat) }
    let(:flat) { FactoryBot.create(:flat) }
    let(:expected_message) {
      <<~FLAT
        Neues Angebot!
        https://inberlinwohnen.de/something::123/456/789.html
        Miete: 1.234,00 €
        Adresse: Beispielstr. 60, Spitzenstadtteil
        Zimmeranzahl: 4,00
        Wohnfläche: 85,00 m²
        Bezugsfertig ab: ab sofort
        Etage: 4 (von insg. 6)
        Baujahr: 2023
        Hauptenergieträger: Fernwärme
        Energieausweis: bedarfsausweis

        Maps: https://www.google.de/maps/place/Beispielstr.+60,+Spitzenstadtteil

        Aktuelle Suche: https://inberlinwohnen.de/wohnungsfinder/?abc12345-Ab
      FLAT
    }

    before do
      stub_const("InBerlinWohnenScraper::URL", "https://inberlinwohnen.de/wohnungsfinder/?abc12345-Ab")
    end

    it "formats message" do
      expect(subject.format_for_chat).to eq(expected_message)
    end
  end
end
