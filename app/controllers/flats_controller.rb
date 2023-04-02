class FlatsController < ApplicationController
  def index
    @flats = Flat.order(id: :desc)
  end
end
