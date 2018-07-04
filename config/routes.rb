Rails.application.routes.draw do
  resources :lessons, except: %i[new edit]
end
