Rails.application.routes.draw do
  
  namespace :admin do
  
    post "/markdown/preview" => "markdown#preview"
    resources :uploads
    
  end
  
end
