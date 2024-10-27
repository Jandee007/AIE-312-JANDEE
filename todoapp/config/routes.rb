Rails.application.routes.draw do
  resources :tasks do
    member do
      get 'complete'  # for marking tasks as complete
    end
  end
  
  root "tasks#index"
end
