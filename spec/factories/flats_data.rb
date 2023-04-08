FactoryBot.define do
  factory :formatted_flats_data, class: Array do
    skip_create

    transient do
      first_external_id { "flat_#{SecureRandom.hex}" }
    end

    initialize_with do
      new([
        {
          "external_id"=>first_external_id,
          "link"=>"https://inberlinwohnen.de/asd::321/654/987.html",
          "attr"=> {
            "Miete"=>"987,00 €",
            "Adresse"=>"Tolle Straße 35A, Irgendwo",
            "Zimmeranzahl"=>"3,00",
            "Wohnfläche"=>"80,00 m²",
            "Bezugsfertig ab"=>"ab sofort",
            "Etage"=>"3 (von insg. 6)",
            "Baujahr"=>"2023",
            "Hauptenergieträger"=>"Fernwärme",
            "Energieausweis"=>"bedarfsausweis"
          }
        }, {
          "external_id"=>"flat_#{SecureRandom.hex}",
          "link"=>"https://inberlinwohnen.de/dsa::987/654/321.html",
          "attr"=> {
            "Miete"=>"1.234,00 €",
            "Adresse"=>"Andere Straße 60, Woanders",
            "Zimmeranzahl"=>"4,00",
            "Wohnfläche"=>"85,00 m²",
            "Bezugsfertig ab"=>"ab sofort",
            "Etage"=>"4 (von insg. 6)",
            "Baujahr"=>"2023",
            "Hauptenergieträger"=>"Fernwärme",
            "Energieausweis"=>"bedarfsausweis"
          }
        }
      ])
    end
  end
end
