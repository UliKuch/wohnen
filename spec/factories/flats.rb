FactoryBot.define do
  factory :flat do
    external_id { "flat_#{SecureRandom.hex}" }
    link { "https://inberlinwohnen.de/something::123/456/789.html" }
    attr {
      {
        "Miete" => "1.234,00 €",                                   
        "Adresse" => "Beispielstr. 60, Spitzenstadtteil",         
        "Zimmeranzahl" => "4,00",                                  
        "Wohnfläche" => "85,00 m²",                                
        "Bezugsfertig ab" => "ab sofort",                          
        "Etage" => "4 (von insg. 6)",                              
        "Baujahr" => "2023",                                       
        "Hauptenergieträger" => "Fernwärme",                       
        "Energieausweis" => "bedarfsausweis"
      }
    }
  end
end
