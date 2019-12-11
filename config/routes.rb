Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


	root to: "application#hello"
	namespace :api do
		namespace :v1 do
				post 'auth/login', 						to: 'authentication#authenticate'
				post 'signup', 								to: 'users#create'
				post 'orders/create'
				put 'orders/update'
				get 'orders', 								to: 'orders#index'
				get 'orders/show/:order_id', 						to: 'orders#show'
				post 'users/status', 					to: "users#privy_status"
				
				get 'users/collateral',				to: "users#search_collateral_owner"
				get 'users/debitor',					to: "users#search_debitor"
				get 'users/creditor',					to: "users#search_creditor"

				get 'users/roles', 						to: "users#roles"
        get 'users/notaris',      		to: "users#notaris"
				get 'users/notaris_detail/:id', 			to: "users#notaris_detail"
				get 'users/show', 						to: 'users#show'
				put 'users/edit', 						to: 'users#edit'
				post 'users/forgot', 					to: 'users#forgot'
				post 'users/reset', 					to: 'users#reset'
				get 'provinces/all', 					to: 'indonesias#provinces'
				get 'cities/:province_id', 		to: 'indonesias#cities'
				get 'districts/:city_id', 		to: 'indonesias#districts'
				get 'villages/:district_id', 	to: 'indonesias#villages'

				resource :collateral, only: [:show, :create, :destroy]
				resource :document, only: [:show]
				post 'document/upload', 			to: 'documents#upload'
				post 'document/generate', 		to: 'documents#generate_pdf'
				post 'document/parties',	 		to: 'documents#parties'
				post 'document/approval',	 		to: 'documents#approval'

        resource :chats, only: [:show, :create, :destroy]
        # resource :carts, only: [:index]
				get 'carts', to: 'carts#index'
				
			

		end
	end
end
