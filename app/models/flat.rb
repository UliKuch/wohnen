class Flat < ApplicationRecord
  def google_maps_link
    return if attr["Adresse"].blank?
    "https://www.google.de/maps/place/" + attr["Adresse"].gsub(" ", "+")
  end
end
