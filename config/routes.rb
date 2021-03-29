Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :admin do
  	resources :games, only: [:new, :edit, :show, :create, :update]
  end

  resources :tasks, only: [:show]
  # get '/tasks/:id', to: 'tasks#show'
end
