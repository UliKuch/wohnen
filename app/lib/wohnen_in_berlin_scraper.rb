class WohnenInBerlinScraper
  BASE_URL = "https://inberlinwohnen.de"
  FINDER_PATH = "wohnungsfinder"
  QUERY_STR = "hgk38762-kV"
  URL = "#{BASE_URL}/#{FINDER_PATH}/?#{QUERY_STR}"
  FLAT_CSS_FINDER = "li.tb-merkflat"
  BUTTON_LINK_CSS_FINDER = "a.org-but"

  attr_accessor :flats

  def initialize
  end

  def get_and_persist_flats
    scrape
    persist_flats
  end

  private

  def scrape
    flats_results = get_raw_flats_data

    @flats = flats_results.map do |flat_node|
      read_flat_data_from_node(flat_node)
    end
  end

  def persist_flats
    flats.each do |flat|
      PersistFlat.new(flat).find_or_create
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

    table_elements = flat_node.css("tr")
    table_elements.each do |element|
      key = element.at("th").children.text.gsub(":", "").strip
      value = element.at("td").text
      flat_hash["attr"][key] = value
    end

    flat_hash
  end
end
