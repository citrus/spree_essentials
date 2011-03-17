Rails.application.routes.draw do
  
  #get "/blog" => "posts#index", :as =>
  
  resources :posts, :path => 'blog' do
    get :archive, :on => :collection
  end
  
  namespace :admin do
  
    post "/markdown/preview" => "markdown#preview"
  
    resources :pages do
      resources :contents
    end
    
    resources :posts do 
      resources :images, :controller => "post_images"
    end
    
  end
  
end