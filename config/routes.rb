EZNotes::Application.routes.draw do
  resources :users 
  resources :sessions,  only: [:new, :create, :destroy]
  resources :notes,     only: [:create, :destroy]
  resources :courses,   only: [:show, :index, :create, :destroy, :update] 
  resources :course_imports
  resources :registrations, only: [:create, :destroy]
  
  root to: 'static_pages#home'

  match '/notes/:id/:style.:extension', to: 'notes#download', via: 'get'

  match '/signup',  to: 'users#new',          via: 'get'
  match '/signin',  to: 'sessions#new',       via: 'get'
  match '/signout', to: 'sessions#destroy',   via: 'delete'
  match '/delete_all', to: 'courses#delete_all',        via: 'delete'

  match '/create_admin', to: 'users#create_admin',        via: 'put'

  match '/help', to: 'static_pages#help',	via:'get'
  match '/about', to: 'static_pages#about',	via:'get'
  match '/contact', to: 'static_pages#contact',	via:'get'
end
