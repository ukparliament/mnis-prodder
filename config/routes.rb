Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  get 'mnis-prodder' => 'home#index', :as => 'home'
  get 'mnis-prodder/lookup' => 'home#lookup', :as => 'home_lookup'
  get 'mnis-prodder/form-parse' => 'home#form_parse', :as => 'home_parse'
  get 'mnis-prodder/parse' => 'parse#parse', :as => 'parse'
end
