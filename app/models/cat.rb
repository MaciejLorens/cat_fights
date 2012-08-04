class Cat < ActiveRecord::Base
    attr_accessible :image, :total_points

    WIN_POINT = 1
    LOSE_POINT = -1
    DRAW_POINT = 0.5

    QUERY_RESULTS_LIMIT = 10
end
