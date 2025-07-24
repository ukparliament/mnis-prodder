Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  mount LibraryDesign::Engine => "/library_design"

  # Defines the root path route ("/")
  root "home#index"

  get 'mnis-prodder' => 'home#index', :as => 'home'
  get 'mnis-prodder/lookup' => 'home#lookup', :as => 'home_lookup'
  get 'mnis-prodder/form-parse' => 'home#form_parse', :as => 'home_parse'
  get 'mnis-prodder/parse' => 'parse#parse', :as => 'parse'
  
  get 'mnis-prodder/meta' => 'meta#index', :as => 'meta_list'
  get 'mnis-prodder/meta/cookies' => 'meta#cookies', :as => 'meta_cookies'
end
