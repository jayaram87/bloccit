Rails.application.routes.draw do
<<<<<<< HEAD
  resources :topics do
    resources :posts, except: [:index]
  end
=======
  resources :questions

  resources :posts
>>>>>>> 548638f6c39d4760afc7be494b8d9cfe373f06da

  get 'about' => 'welcome#about'
  
  get 'welcome/contact'
  
  root 'welcome#index'

end
