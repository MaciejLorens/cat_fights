class Vote < ActiveRecord::Base
  belongs_to :Cat
  attr_accessible :value
end
