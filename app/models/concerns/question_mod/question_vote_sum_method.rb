module QuestionMod
  module QuestionVoteSumMethod
    extend ActiveSupport::Concern
    
    Vote.class_eval do
      belongs_to :question, class_name: 'QuestionMod::Question'
    end
  end
end