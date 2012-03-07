#Rails.application
Spree::Core::Engine.routes.draw do
  namespace :admin do
    post "/markdown/preview" => "markdown#preview", :as => :markdown_preview
    resources :uploads
  end
end
