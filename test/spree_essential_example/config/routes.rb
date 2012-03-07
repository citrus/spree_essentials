Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :examples
  end
end
