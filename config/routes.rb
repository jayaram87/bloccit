Rails.application.routes.draw do
  resources :topics do
    resources :posts, except: [:index]
  end
  
  resources :topics do
    resources :sponsorposts, except: [:index]
  end

  get 'about' => 'welcome#about'
  
  root 'welcome#index'

end
