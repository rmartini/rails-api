Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :v2 do
    resources :banks, only: :index
  end

  namespace :v1 do
    resources :operations
    resources :banks do
      resources :bank_periods
    end
  end

end
