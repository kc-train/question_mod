module QuestionMod
  class Question
    include Mongoid::Document
    include Mongoid::Timestamps

    # title content 不能为空
    field :title,   :type => String
    field :content, :type => String
    # 统计 所有 QuestionVote 的值总和
    # up +1
    # down -1
    field :vote_sum, :type => Integer, :default => 0

    validates :title, :presence => true
    validates :content, :presence => true 
    # creator 不能为空
    belongs_to :creator,        :class_name => QuestionMod.user_name
    # belongs_to :creator,        :class_name => current_user.name
    has_many   :answers,        :class_name => QuestionMod::Answer.name
    has_many   :question_votes, :class_name => QuestionMod::QuestionVote.name
  end
end