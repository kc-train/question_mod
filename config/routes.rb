QuestionMod::Engine.routes.draw do
  root 'home#index'
  resources :questions do
    resources :question_comments 
    resources :question_votes do
      collection do
        get 'agree'
        get 'against'
      end
    end

    resources :answers do
      resources :answer_comments 
      resources :answer_votes do
        collection do
          get 'agree'
          get 'against'
        end
      end
    end
  end 
end
