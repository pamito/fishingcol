Rails.application.routes.draw do
  
  
  resources :categories
  devise_for :users
  #esto sirve para solo funcione los controladores de comment cuando trabajemos en articulos, no separado
  resources :articles do
    get "user/:user_id", to: "articles#from_author", on: :collection
    resources :comments
    
  end
 
   #get "/articles" INDEX
   #post "/articles" CREATE
   #delete "/articles"DELETE
   #get "/articles/:id"SHOW
   #get "/articles/new" NEw
   #get "/articles/:id/edi t" EDIT
   #patch "/articles/:id" update
   #put "/articles/:id" update 

  root 'articles#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
