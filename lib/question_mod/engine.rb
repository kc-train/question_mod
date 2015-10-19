module QuestionMod
  class Engine < ::Rails::Engine
    isolate_namespace QuestionMod
    config.to_prepare do
      ApplicationController.helper ::ApplicationHelper

      User.class_eval do
        has_many :questions, class_name: 'QuestionMod::Question'
        has_many :answers, class_name: 'QuestionMod::Answer'
        has_many :comment, class_name: 'QuestionMod::Comment'
      end
    end
  end
end