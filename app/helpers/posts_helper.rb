module PostsHelper

  def post_seo_path(post)
    full_post_path(post.year, post.month, post.day, post.to_param)
  end
  
  def date_full(date)
    date.strftime('%A %B %d, %Y').gsub(/\s0/, ' ')
  end

end