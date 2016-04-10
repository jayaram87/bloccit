Rails.application.routes.draw do
  resources :topics do
    resources :posts, except: [:index]
  end
  
  resources :topics do
    resources :sponsor_posts, except: [:index]
  end

  get 'about' => 'welcome#about'
  
  root 'welcome#index'

end
