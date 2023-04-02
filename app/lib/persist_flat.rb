class PersistFlat
  attr_reader :flat_hash

  def self.create_or_update(flat_hash)
    new(flat_hash).create_or_update
  end

  def initialize(flat_hash)
    @flat_hash = flat_hash
  end

  def create_or_update
    flat = Flat.where(external_id: flat_hash["external_id"]).first_or_initialize

    flat.link = flat_hash["link"]
    flat.attr = flat_hash["attr"]

    flat.save
  end
end
