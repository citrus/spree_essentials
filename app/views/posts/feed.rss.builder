xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "News - Epsteen &amp; Associates"
    xml.description "News from Epsteen &amp; Associates"
    xml.link posts_url

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description post_html(post)
        xml.pubDate post.posted_at.to_s(:rfc822)
        xml.link post_url(post.year, post.month, post.day, post.to_param)
      end
    end
  end
end