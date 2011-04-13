class PossiblePage
  def self.matches?(request)
    path = request.fullpath
    return false if path =~ /(^\/(admin|account|cart|checkout|content|login|pg\/|orders|products|s\/|signup|states|t\/|tax_categories|session|shipments|user))/
    count = Page.active.where(:path => path).count
    0 < count    
  end
end

Rails.application.routes.draw do
  
  scope(:module => "Blog") do
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
    
  end
  
  namespace :admin do
  
    post "/markdown/preview" => "markdown#preview"
  
    resources :pages do
      collection do
        post :update_positions
      end
      
      resources :contents do
        collection do
          post :update_positions
        end
      end
      
      resources :images,   :controller => "page_images" do
        collection do
          post :update_positions
        end
      end
    end
    
    scope(:module => "Blog") do
      resources :posts do 
        resources :images,   :controller => "post_images" do
          collection do
            post :update_positions
          end
        end
        resources :products, :controller => "post_products"
      end
    end
    
    resources :uploads
    
  end

  constraints(PossiblePage) do
    get '(:page_path)', :to => 'pages#show', :page_path => /.*/, :as => :page
  end
  
end
