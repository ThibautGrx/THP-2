Rails.application.routes.draw do
  resource :lessons, except: %i[new edit]
end
