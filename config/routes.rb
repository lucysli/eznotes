EZNotes::Application.routes.draw do
  get "users/new"

  root to: 'static_pages#home'

  match '/signup', to: 'static_pages#signup',	via:'get'
  match '/signup2', to: 'static_pages#signup2',	via:'get'
  match '/signup3', to: 'static_pages#signup3',	via:'get'
  match '/signup4', to: 'static_pages#signup4',	via:'get'
  match '/signup5', to: 'static_pages#signup5',	via:'get'
  match '/signupsubmit', to: 'static_pages#create', via: 'post'
  match '/help', to: 'static_pages#help',	via:'get'
  match '/about', to: 'static_pages#about',	via:'get'
  match '/contact', to: 'static_pages#contact',	via:'get'
end
