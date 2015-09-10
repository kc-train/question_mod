QuestionMod::Engine.routes.draw do
  root 'home#index'
  resources :questions 
  resources :answers
end