Rails.application.routes.draw do
  scope '(:locale)', locale: /fr|en/ do
    devise_for :users

    mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Defines the root path route ("/")
    # root "articles#index"
    root to: "pages#home"
    # with namespace admin, all the resource routes will be prefixed with the same
    # starting path /admin
    namespace :admin do
      get '/', to: "admin#index"
      resources :questions do
        resources :answers, only: [:edit, :update]
      end
      resources :lexicons do
        resources :lexicon_answers, only: [:edit, :update]
      end
    end

    get "/ressources", to: "pages#ressources"
    get "qcm", to: "questions#qcm"
    get "/missed_questions", to: "questions#missed_questions"

    resources :questions, only: [:index]  do
      member do
        get 'add_failed_question'
        get 'destroy_failed_question'
      end
      collection do
        post 'add_failed_questions'
        post 'destroy_failed_questions'
      end
    end

    resources :lexicons, only: [:index] do
      # url /lexicons/qcm
      collection do
        get "qcm", to: "lexicons#qcm"
      end
    end
  end
end
