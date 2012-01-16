::Spree::Asset.class_eval do
  
  def has_alt?
    alt.present?
  end

end
