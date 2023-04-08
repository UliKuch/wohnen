class InBerlinWohnenScraper
  BASE_URL = "https://inberlinwohnen.de"
  FINDER_PATH = "wohnungsfinder"
  URL = "#{BASE_URL}/#{FINDER_PATH}/?#{ENV["QUERY_TOKEN"]}"
  FLAT_CSS_FINDER = "li.tb-merkflat"
  BUTTON_LINK_CSS_FINDER = "a.org-but"
  PRICE_REGEX = /\d*.?\d*,?\d*\s*€/

  attr_accessor :flats_data

  def scrape
    raw_flats_data = get_raw_flats_data

    @flats_data = raw_flats_data.map do |flat_node|
      read_flat_data_from_node(flat_node)
    end
  end

  private

  def get_raw_flats_data
    uri = URI.parse(URL)
    res = Faraday.get(uri)
    document = Nokogiri::HTML(res.body)
    document.css(FLAT_CSS_FINDER)
  end

  def read_flat_data_from_node(flat_node)
    flat_data = {}
    flat_data["external_id"] = flat_node&.attributes&.dig("id")&.value
    rel_link = flat_node.at(BUTTON_LINK_CSS_FINDER)&.attributes&.dig("href")&.value
    flat_data["link"] = "#{BASE_URL}#{rel_link}".gsub(" ", "%20")
    flat_data["attr"] = {}

    flat_data["attr"]["Miete"] = flat_node.at("h3").text.match(PRICE_REGEX).to_s.squish

    table_elements = flat_node.css("tr")
    table_elements.each do |element|
      key = element.at("th").children.text.gsub(":", "").strip
      value = element.at("td").text
      flat_data["attr"][key] = value
    end

    flat_data
  end
end
