QuestionMod::Engine.routes.draw do
  root 'home#index'
  resources :questions do
    member do
      put :vote_up
      put :vote_down
    end
    resources :question_comments, :path => :comments

    resources :answers do
      member do
        put :vote_up
        put :vote_down
      end
      resources :answer_comments, :path => :comments
    end
  end
end
