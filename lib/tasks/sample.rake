namespace :db do
  namespace :sample do
    desc "creates sample blog posts"
    task :blog do
      
      require 'faker'
      require Rails.root.join('config/environment.rb')
        
      image_dir = File.expand_path("../sample", __FILE__)
      images    = Dir[image_dir + "/*.jpg"]
      
      product_ids = Product.select('id').all.collect(&:id) rescue []
      
      50.times { |i|
      
        post = Post.create(
          :title     => Faker::Lorem.sentence,
          :posted_at => Time.now - i * rand(10000000),
          :body      => Faker::Lorem.paragraph,
          :tag_list  => Faker::Lorem.words(rand(10)).join(", ")
        )
        
        rand(5).times { |i|
          image = post.images.create(:attachment => File.open(images.sort_by{rand}.first), :alt => Faker::Lorem.sentence)
        }
        
        unless product_ids.empty?
          rand(5).times { |i|
            post.post_products.create(:product => Product.find(product_ids.sort_by{rand}.first), :position => i)
          }
        end
      }
      
    end
  end
end