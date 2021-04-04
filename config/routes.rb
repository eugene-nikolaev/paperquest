Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :admin do
  	get '/', to: "pages#index"
  	post '/search', to: "pages#search", as: :search_games
  	resources :games, only: [:new, :edit, :show, :create, :update] do
  		member do
  			get :print
  			get :reset
  		end
  	end
  end

  resources :tasks, only: [:show]
  # get '/tasks/:id', to: 'tasks#show'
end
