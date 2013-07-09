EZNotes::Application.routes.draw do
  resources :users
  root to: 'static_pages#home'
  match '/signup', to: 'users#new', via: 'get'

  match '/notetaker', to: 'static_pages#notetaker', via:'get'
  match '/notetaker2', to: 'static_pages#notetaker2', via:'get'

  match '/signin', to: 'static_pages#home',  via:'post'
  match '/upload', to: 'static_pages#notetaker2', via:'post'

  match '/signup2', to: 'static_pages#signup2',	via:'get'
  match '/signup3', to: 'static_pages#signup3',	via:'get'
  match '/signup4', to: 'static_pages#signup4',	via:'get'
  match '/signup5', to: 'static_pages#signup5',	via:'get'
  match '/signupsubmit', to: 'static_pages#signup4',	via:'post'
  match '/help', to: 'static_pages#help',	via:'get'
  match '/about', to: 'static_pages#about',	via:'get'
  match '/contact', to: 'static_pages#contact',	via:'get'
end
