class FlatsController < ApplicationController
  
  # TODO: Add basic auth
  
  def index
    @flats = Flat.all
  end
end
