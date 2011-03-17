class Content < ActiveRecord::Base

  belongs_to :page
  
  validates_presence_of :title, :page
   
  validates_uniqueness_of :page
   
  cattr_reader :per_page
  @@per_page = 10
  
  after_save :save_title
  
  def has_link?
    (link && link_text) && !(link.empty? && link_text.empty?)
  end 
  
  def save_title
    self.image_title.say(self.title, :width => get_width)
  end
  
  def get_width
    case self.page
      when "Home"
        w = 215
      when "Roots"
        w = 415
      when "Shop"
        w = 285
      when "Contact"
        w = 480 
      else
        w = 400 
    end
    w
  end
  		
end
