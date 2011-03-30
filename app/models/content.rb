class Content < ActiveRecord::Base

  belongs_to :page
  validates_presence_of :title, :page
    		
end