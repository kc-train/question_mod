module QuestionMod
  class QuestionVote
    extend Enumerize

    include Mongoid::Document
    include Mongoid::Timestamps

    # up down 二选一
    enumerize :kind, in: [:up, :down]

    # creator 不能为空
    belongs_to :creator,  :class_name => QuestionMod.user_name

    # question 不能为空
    belongs_to :question, :class_name => QuestionMod::Question.name
  end
end