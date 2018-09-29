Rails.application.routes.draw do
	# Auth Methods
	post 'signup', to: 'users#create'
  post 'auth/login', to: 'authentication#authenticate'

  namespace :v1 do
	  resources :people
	  resources :movies
	  resources :movies_people
	end
end
