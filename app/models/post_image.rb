class PostImage < Image

  has_attached_file :attachment, 
                    :styles => { :mini => '48x48>', :small => '120x100>', :preview => '528x420>', :large => '800x375#' },
                    :default_style => :preview,
                    :url => "/assets/posts/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/posts/:id/:style/:basename.:extension"
 
  validates_attachment_presence :attachment

end
