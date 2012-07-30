class TopPictureTotalController < ApplicationController
  def index
    @cats = Cat.order("total_points DESC")
  end
end
