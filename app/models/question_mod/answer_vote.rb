module QuestionMod
  class AnswerVote
    extend Enumerize

    include Mongoid::Document
    include Mongoid::Timestamps

    # up down 二选一
    enumerize :kind, in: [:up, :down]

    # creator 不能为空
    belongs_to :creator, :class_name => 'User'
    # answer 不能为空
    belongs_to :answer, :class_name => 'QuestionMod::Answer'
  end
end