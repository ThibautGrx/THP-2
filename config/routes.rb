Rails.application.routes.draw do
  resources :lessons, except: %i[new edit], constraints: { id: /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/ }
end
