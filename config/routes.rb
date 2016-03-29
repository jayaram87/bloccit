Rails.application.routes.draw do

  resources :topics do
    resources :posts, except: [:index]
  end

  resources :questions

  resources :users, only: [:new, :create]

  get 'about' => 'welcome#about'
  
  get 'welcome/contact'
  
  root 'welcome#index'

end
