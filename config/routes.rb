Rails.application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "sayhello", to: "application#hello"
	post 'auth/login', to: 'authentication#authenticate'
	post 'signup', to: 'users#create'
	post 'privy/status', to: "users#privy_status"
	namespace :v1 do
	    post 'orders/create'
	end

end
