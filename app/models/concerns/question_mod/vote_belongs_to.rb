module QuestionMod
  module VoteBelongsTo
    extend ActiveSupport::Concern
    
    Vote.class_eval do
      belongs_to :question, class_name: 'QuestionMod::Question'
      belongs_to :answer, class_name: 'QuestionMod::Answer'
    end
  end
end