class FlatFormatter
  attr_reader :flat

  def initialize(flat:)
    @flat = flat
  end

  def format_for_chat
    <<~FLAT
      Neues Angebot!
      #{flat.link}
      #{flat.attr.map { |k, v| "#{k}: #{v}" }.join("\n")}

      Maps: #{flat.google_maps_link}

      Aktuelle Suche: #{InBerlinWohnenScraper::URL}
    FLAT
  end
end
