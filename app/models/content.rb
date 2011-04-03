class Content < ActiveRecord::Base

  belongs_to :page
  validates_presence_of :title, :page
    		
  # ensure a string is always returned
  def body
    read_attribute(:body).to_s
  end
    		
end