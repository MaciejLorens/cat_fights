# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cat.destroy_all

10.times do |index|
  cat = Cat.new(:image => "cat#{index}.jpg", :total_points => 0)
  cat.save
end

Vote.destroy_all
