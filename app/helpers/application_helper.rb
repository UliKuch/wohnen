module ApplicationHelper
  def google_maps_link(address)
    "https://www.google.de/maps/place/" + address.gsub(" ", "+")
  end
end
