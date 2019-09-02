Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "sayhello", to: "application#hello"
	post 'auth/login', to: 'authentication#authenticate'

end
