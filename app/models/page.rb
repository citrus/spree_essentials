class Page < ActiveRecord::Base
  
  validates_presence_of :title, :path
  validates_uniqueness_of :path
  
  scope :active,  where(:accessible => true)
  scope :visible, active.where(:visible => true)
  
  has_many :contents, :order => :position, :dependent => :destroy
  
  before_validation :set_defaults
  
  def self.find_by_path(_path)
    return super("/") if _path == 'home'
    super("/" + _path.to_s.sub(/^\//, '').gsub('--', '/'))
  end
  
  def to_param
    return 'home' if path == '/'
    path.sub(/^\//, '').gsub('/', '--')
  end
  
  def meta_title
    val = read_attribute(:meta_title)
    val.blank? ? title : val
  end
  
  private
  
    def set_defaults
      self.nav_title = title if nav_title.blank?
      self.path = nav_title.parameterize if path.blank?
      self.path = "/" + path.sub(/^\//, '')
    end
  		
end
  