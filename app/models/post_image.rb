class PostImage < Image

  validate :no_attachement_errors

  if defined?(SpreeHeroku)
    has_attached_file :attachment,
      :styles => Proc.new{ |clip| clip.instance.attachment_sizes },
      :default_style => :medium,
      :path => "assets/posts/:id/:style/:basename.:extension",
      :storage => "s3",
      :s3_credentials => "#{Rails.root}/config/s3.yml"
  else
    has_attached_file :attachment,
      :styles => Proc.new{ |clip| clip.instance.attachment_sizes },
      :default_style => :medium,
      :url => "/assets/posts/:id/:style/:basename.:extension",
      :path => ":rails_root/public/assets/posts/:id/:style/:basename.:extension"
  end 
 
  def image_content?
    attachment_content_type.match(/\/(jpeg|png|gif|tiff|x-photoshop)/)
  end
     
  def attachment_sizes
    if image_content?
      { :mini => '48x48>', :small => '150x150>', :medium => '600x600>', :large => '950x700>' }
    else
      {}
    end
  end
  
  def no_attachement_errors
    unless attachment.errors.empty?
      # uncomment this to get rid of the less-than-useful interrim messages
      # errors.clear
      errors.add :attachment, "Paperclip returned errors for file '#{attachment_file_name}' - check ImageMagick installation or image source file."
      false
    end
  end
  
end
