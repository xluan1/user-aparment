require 'sidekiq/web'
# Configure Sidekiq-specific session middleware
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

Rails.application.routes.draw do
  mount Sidekiq::Web => "sidekiq"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :user, :organization, :user_account, :transaction
end
