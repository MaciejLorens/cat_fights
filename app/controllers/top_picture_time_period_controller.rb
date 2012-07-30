class TopPictureTimePeriodController < ApplicationController
  def index
    @time_periods_for_select_tag = [['daily', :daily], ['weekly', :weekly], ['monthly', :monthly]]
    @cats = []

    params[:time_period] ||= 'daily'

    cats_id_arr = get_cats_id_array(params[:time_period])
    cats_id_arr.each do |cat_id|
      @cats << Cat.find(cat_id)
    end

    @cats_score_arr = get_cats_score_array(params[:time_period])
  end

  def get_cats_score_array(time_period)
    cats_score_arr = []
    case time_period
      when 'daily' then
        cats_score_arr = Vote.select('sum("value")').where('created_at > ?', DateTime.now - 1.day).group('"Cat_id"').order('sum("value") DESC').pluck('sum("value")')
      when 'weekly' then
        cats_score_arr = Vote.select('sum("value")').where('created_at > ?', DateTime.now - 1.week).group('"Cat_id"').order('sum("value") DESC').pluck('sum("value")')
      when 'monthly' then
        cats_score_arr = Vote.select('sum("value")').where('created_at > ?', DateTime.now - 1.month).group('"Cat_id"').order('sum("value") DESC').pluck('sum("value")')
    end
    cats_score_arr
  end

  def get_cats_id_array(time_period)
    cats_id_arr = []
    case time_period
      when 'daily' then
        cats_id_arr = Vote.select('"Cat_id"').where('created_at > ?', DateTime.now - 1.day).group('"Cat_id"').order('sum("value") DESC').pluck('"Cat_id"')
      when 'weekly' then
        cats_id_arr = Vote.select('"Cat_id"').where('created_at > ?', DateTime.now - 1.week).group('"Cat_id"').order('sum("value") DESC').pluck('"Cat_id"')
      when 'monthly' then
        cats_id_arr = Vote.select('"Cat_id"').where('created_at > ?', DateTime.now - 1.month).group('"Cat_id"').order('sum("value") DESC').pluck('"Cat_id"')
    end
    cats_id_arr
  end
end
