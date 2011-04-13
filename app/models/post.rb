class Post < ActiveRecord::Base
  
  acts_as_taggable
  
  has_many :post_products, :dependent => :destroy
  has_many :products, :through => :post_products
  
  has_many :images, :as => :viewable, :class_name => 'PostImage', :order => :position, :dependent => :destroy
  
  validates :title, :presence => true
  validates :path,  :presence => true, :uniqueness => true, :if => proc{ |record| !record.title.blank? }
  validates :body,  :presence => true
  validates :posted_at, :datetime => true
  
  cattr_reader :per_page
  @@per_page = 10

  scope :live, where(:live => true ).order('posted_at DESC')

 	before_validation :create_path
  
  
  # Creates date-part accessor for the posted_at timestamp for grouping purposes.
  %w(day month year).each do |method|
    define_method method do
      self.posted_at.send(method)
    end
  end
  	
	def rendered_preview
    preview = body.split("<!-- more -->")[0]
    render(preview)
  end
	
	def rendered_body
	  render(:body).gsub("<!-- more -->", "")
  end
		
	def preview_image
    images.first if has_images?	  
	end

  def has_images?
    images && !images.empty?
  end
  

  def live?
    live && live == true
  end

  def to_param
		path
	end
	
	
	private
	
    def render(val)
      val = val.is_a?(Symbol) ? send(val) : val
      RDiscount.new(val).to_html.html_safe
    end
		
    def create_path
  		#downcase.gsub(/\s/, '-').gsub(/[^a-z0-9\-\_]/, '').gsub(/[\-]+/, '-')
  		count = 2
  		new_path = title.to_s.parameterize
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