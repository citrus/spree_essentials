Asset.class_eval do

  def has_alt?
    !alt.blank?
  end

end
