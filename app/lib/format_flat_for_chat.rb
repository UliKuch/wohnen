class FormatFlatForChat
  attr_reader :flat

  def self.format(flat)
    new(flat).format
  end

  def initialize(flat)
    @flat = flat
  end

  def format
    <<~FLAT
      Neues Angebot!
      #{flat.link}
      #{flat.attr.map { |k, v| "#{k}: #{v}" }.join("\n")}

      Maps: #{flat.google_maps_link}

      Aktuelle Suche: #{InBerlinWohnenScraper::URL}
    FLAT
  end
end
