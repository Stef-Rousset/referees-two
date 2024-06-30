Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'pages#home'
  get "/ressources", to: "pages#ressources"
  get "qcm", to: "questions#qcm"
  get "/missed_questions", to: "questions#missed_questions"
  get '/dashboard', to: 'questions#dashboard'
  resources :questions do
    resources :answers, only: [:edit, :update]
    member do
      post 'add_failed_question'
      post 'destroy_failed_question'
    end
  end
end
