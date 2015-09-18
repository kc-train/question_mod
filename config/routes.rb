QuestionMod::Engine.routes.draw do
  root 'home#index'
  resources :questions
  resources :answers
  resources :question_votes
  resources :answer_votes
end
