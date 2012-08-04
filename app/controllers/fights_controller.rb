class FightsController < ApplicationController

    def index
        @cat1 = get_random_cat
        begin
            @cat2 = get_random_cat
        end while @cat1 == @cat2
    end

    def vote
        @win_cat = Cat.find(params[:id_win])
        @lose_cat = Cat.find(params[:id_lose])

        return if @win_cat.nil? || @win_cat.nil?

        @win_vote = Vote.new
        @lose_vote = Vote.new

        @win_vote.Cat_id = @win_cat.id
        @lose_vote.Cat_id = @lose_cat.id

        @win_cat.total_points += Cat::WIN_POINT
        @lose_cat.total_points += Cat::LOSE_POINT

        @win_vote.value = Cat::WIN_POINT
        @lose_vote.value = Cat::LOSE_POINT

        ActiveRecord::Base.transaction do
            @win_cat.save
            @lose_cat.save

            @win_vote.save
            @lose_vote.save
        end

        flash[:notice] = "you have voted on #{@win_cat.image}!"

        redirect_to :action => 'index'
    end

    private
    def get_random_cat
        cat = Cat.find_by_image(random_image) while cat.nil?
        cat
    end
end
