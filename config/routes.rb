Rails.application.routes.draw do
	# Auth Methods
	post 'signup', to: 'users#create'
  post 'auth/login', to: 'authentication#authenticate'

  resources :people
  resources :movies
  resources :movies_people
end
