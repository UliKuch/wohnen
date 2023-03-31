class WohnenInBerlinScraper
  BASE_URL = "https://inberlinwohnen.de"
  FINDER_PATH = "wohnungsfinder"
  QUERY_TOKEN = "dDn38787-Pc"
  URL = "#{BASE_URL}/#{FINDER_PATH}/?#{QUERY_TOKEN}"
  FLAT_CSS_FINDER = "li.tb-merkflat"
  BUTTON_LINK_CSS_FINDER = "a.org-but"
  PRICE_REGEX = /\d*.?\d*,?\d*\s*€/

  attr_accessor :flats

  def initialize
  end

  def scrape_and_persist
    scrape
    create_or_update_flats
  end

  private

  def scrape
    flats_results = get_raw_flats_data

    @flats = flats_results.map do |flat_node|
      read_flat_data_from_node(flat_node)
    end
  end

  def create_or_update_flats
    flats.each do |flat|
      PersistFlat.new(flat).create_or_update
    end
  end

  def get_raw_flats_data
    uri = URI.parse(URL)
    res = Faraday.get(uri)
    document = Nokogiri::HTML(res.body)
    document.css(FLAT_CSS_FINDER)
  end

  def read_flat_data_from_node(flat_node)
    flat_hash = {}
    flat_hash["external_id"] = flat_node&.attributes&.dig("id")&.value
    rel_link = flat_node.at(BUTTON_LINK_CSS_FINDER)&.attributes&.dig("href")&.value
    flat_hash["link"] = "#{BASE_URL}#{rel_link}".gsub(" ", "%20")
    flat_hash["attr"] = {}

    flat_hash["attr"]["Miete"] = flat_node.at("h3").text.match(PRICE_REGEX).to_s.squish

    table_elements = flat_node.css("tr")
    table_elements.each do |element|
      key = element.at("th").children.text.gsub(":", "").strip
      value = element.at("td").text
      flat_hash["attr"][key] = value
    end

    flat_hash
  end
end
