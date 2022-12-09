Rails.application.routes.draw do
  concern :paginatable do
    get '(/:page)', action: :index, on: :collection, as: ''
  end

  resources :books, concerns: :paginatable
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
