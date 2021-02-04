Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get("/",{to: "welcome#index", as: :root}) 

  
  resources :posts do 
  resources :comments, only:[:create, :destroy]
  end
      
  resources :users, only:[:new, :create]
  resource :user, only: [:edit, :update]
  resource :session, only:[:new, :create, :destroy]

end
