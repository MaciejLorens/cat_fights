class PhotosController < ApplicationController
    require 'flickr_fu'
    require "open-uri"

    def index
        flickr = Flickr.new('config/flickr.yml')

        @photos = flickr.photos.search(:tags => 'cat', :per_page => '240', :page => '24')
        @photos = @photos.paginate(:page => params[:page], :per_page => 24)
    end

    def create_cats
        photos_paths = params[:photos_paths].split(',')
        return if photos_paths.blank?

        photos_paths.each do |photo|
            ActiveRecord::Base.transaction do
                new_cat_name = File.basename(photo)
                next unless Cat.find_by_image(new_cat_name).nil?

                #save image on HDD
                new_cat_image_data = open(photo).read
                new_cat_image = open("#{Rails.root}/public/images/cats/#{new_cat_name}", "wb")
                new_cat_image.write(new_cat_image_data)
                new_cat_image.close

                #create new record in DB
                new_cat = Cat.new
                new_cat.image = new_cat_name
                new_cat.total_points = 0
                new_cat.save
            end
        end

        flash[:notice] = "Your cat(s) was successfully added!"
        redirect_to :action => 'index'
    end
end
