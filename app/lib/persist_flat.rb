class PersistFlat
  attr_reader :flats_data
  attr_accessor :flats

  def initialize(flats_data:)
    @flats_data = flats_data
    @flats = []   
  end

  def create_or_update_flats
    flats_data.each do |flat_data|
      create_or_update(flat_data)
    end
  end

  private

  def create_or_update(flat_data)
    flat = Flat.where(external_id: flat_data["external_id"]).first_or_initialize

    flat.link = flat_data["link"]
    flat.attr = flat_data["attr"]

    if flat.save
      flats << flat
    end
  end
end
