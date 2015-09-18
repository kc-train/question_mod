QuestionMod::Engine.routes.draw do
  root 'home#index'
  resources :questions 
  resources :question_votes
  resources :answers
  resources :answer_votes
end
