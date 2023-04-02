class FormatFlatForChat
  attr_reader :flat

  def self.format(flat_id)
    new(flat_id).format
  end

  def initialize(flat_id)
    @flat = Flat.find(flat_id)
  end

  def format
    <<~FLAT
      Neues Angebot!
      #{flat.link}
      #{flat.attr.map { |k, v| "#{k}: #{v}" }.join("\n")}

      Maps: #{flat.google_maps_link}

      Aktuelle Suche: #{WohnenInBerlinScraper::URL}
    FLAT
  end
end
