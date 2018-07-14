Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :lessons, except: %i[new edit], constraints: { id: /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/ }
end
