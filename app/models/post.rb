class Post < ActiveRecord::Base
  
  acts_as_taggable
  
  has_and_belongs_to_many :products  
  has_many :images, :as => :viewable, :class_name => 'PostImage', :order => :position, :dependent => :destroy
  
  validates_presence_of :title, :path, :body, :posted_at
  
  cattr_reader :per_page
  @@per_page = 10

  scope :live, where(:live => true ).order('posted_at DESC')

 	before_validation :create_path

  def posted_at=(value)
  	write_attribute(:posted_at, value.is_a?(Time) ? value : (Time.parse(value) rescue Time.now))
  end
  
  
  %w(day month year).each do |method|
    define_method method do
      self.posted_at.send(method)
    end
  end
  
  
	#def day
  #  posted_at.day
	#end
	#
	#def month
  #  posted_at.month
	#end
	#
	#def year
  #  posted_at.year
	#end
		
	def preview_image
    images.first if has_preview?	  
	end

  def has_preview?
    images && !images.empty?
  end

  def live?
    live && live == true
  end

  def to_param
		path
	end
	
  def create_path
		count = 2
		new_path = title.downcase.gsub(/\s/, '_').gsub(/[^a-z0-9\_]/, '').gsub(/[\_]+/, '_')
		exists = path_exists?(new_path)
		while exists do
			dupe_path = "#{new_path}_#{count}"
			exists = path_exists?(dupe_path)
			count += 1
		end
		self.path = dupe_path || new_path
	end
	
	def path_exists?(new_path)
		post = Post.find_by_path(new_path)
		same_post = post == self
		return (post != nil && !same_post)
	end
	
end