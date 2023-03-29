class PersistFlat
  attr_reader :flat_hash

  def initialize(flat_hash)
    @flat_hash = flat_hash
  end

  def find_or_create
    flat = Flat.where(external_id: flat_hash["external_id"]).first_or_initialize

    flat.link = flat_hash["link"]
    flat.attr = flat_hash["attr"]

    flat.save
  end
end
