QuestionMod::Engine.routes.draw do
  root 'home#index'
  resources :questions do
    member do
      put :vote_up
      put :vote_down
    end
    resources :question_comments, :path => :comments

    resources :answers do
      resources :answer_comments, :path => :comments
      resources :answer_votes do
        collection do
          get 'agree'
          get 'against'
        end
      end
    end
  end
end
