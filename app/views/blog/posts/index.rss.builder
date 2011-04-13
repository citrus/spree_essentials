xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{Spree::Config[:site_name]} - Blog"
    xml.description "#{Spree::Config[:site_url]} - Blog"
    xml.link posts_url

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description post_rss(post)
        xml.pubDate post.posted_at.to_s(:rfc822)
        xml.link post_seo_path(post)
      end
    end
  end
end