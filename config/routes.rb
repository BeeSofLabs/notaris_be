Rails.application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	
	
	root to: "application#hello"
	namespace :api do
		namespace :v1 do
				post 'auth/login', to: 'authentication#authenticate'
				post 'signup', to: 'users#create'
				post 'privy/status', to: "users#privy_status"
				post 'orders/create'
				get 'users/roles', to: "users#roles"
				get 'users/notaris', to: "users#notaris"
				get 'users/show', to: 'users#show'
				put 'users/edit', to: 'users#edit'
				post 'users/forgot', to: 'users#forgot'
		end

		namespace :cms do
		end
	end
end
