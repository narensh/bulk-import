Rails.application.routes.draw do
  resources :policies, except: [:destroy]
  resources :companies, except: [:destroy]
  resources :employees, except: [:destroy]
  resources :imports, param: :request_id, except: [:destroy, :update, :edit]
end