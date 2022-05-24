Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  get '' => 'home#index', :as => 'home'
  get 'lookup' => 'home#lookup', :as => 'home_lookup'
  get 'form-parse' => 'home#form_parse', :as => 'home_parse'
  get 'parse' => 'parse#parse', :as => 'parse'
end
