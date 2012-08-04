class TopPictureTotalController < ApplicationController
    def index
        @cats = Cat.order("total_points DESC").limit(Cat::QUERY_RESULTS_LIMIT)
    end
end
