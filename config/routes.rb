class PossiblePage
  def self.matches?(request)
    path = request.params[:path].to_s
    puts "checking #{path.inspect}"
    return false if path =~ /account|cart|login|products|users/
    
    puts "searching"
    #@page = Page.find_by_path(path) rescue false
    
    count = Page.active.where(:path => "/" + path).count
    puts "count: #{count}"
    
    0 < count
  end
end

Rails.application.routes.draw do
  
  constraints(
    :year  => /\d{4}/,
    :month => /\d{1,2}/,
    :day   => /\d{1,2}/
  ) do 
    get '/blog/:year(/:month)(/:day)' => 'posts#index', :as => :post_date
    get '/blog/:year/:month/:day/:id' => 'posts#show',  :as => :full_post
  end
  
  get '/blog/search/:query', :to => 'posts#search', :as => :search_posts, :query => /.*/
      
  resources :posts, :path => 'blog' do
    get :archive, :on => :collection
  end
  
  namespace :admin do
  
    post "/markdown/preview" => "markdown#preview"
  
    resources :pages do
      resources :contents, :controller => "page_contents"
    end
    
    resources :posts do 
      resources :images,   :controller => "post_images"
      resources :products, :controller => "post_products"
    end
    
    resources :uploads
    
  end

  constraints(PossiblePage) do
    get '(:path)' => 'pages#show'
  end
  
end
