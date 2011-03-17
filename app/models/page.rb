class Page < ActiveRecord::Base
  
  validates_presence_of :title
  
  has_many :contents
  		
end
  