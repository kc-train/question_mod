module QuestionMod
  module AnswerVoteSumMethod
    extend ActiveSupport::Concern
    
    Vote.class_eval do
      belongs_to :answer, class_name: 'QuestionMod::Answer'
    end
  end
end