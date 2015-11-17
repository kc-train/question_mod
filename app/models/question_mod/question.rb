module QuestionMod
  class Question
    include Mongoid::Document
    include Mongoid::Timestamps
    include QuestionMod::VoteableMethod

    default_scope ->{ order(vote_sum: :desc) }

    # title content 不能为空
    field :title,   :type => String
    field :content, :type => String
    # 统计 所有 QuestionVote 的值总和
    # up +1
    # down -1
    field :vote_sum, :type => Integer, :default => 0

    validates :title, :presence => true
    validates :content, :presence => true
    validates :creator, :presence => true
    # creator 不能为空
    belongs_to :creator,         :class_name => 'User'
    has_many   :votes,  :class_name => 'QuestionMod::Vote', :as => :voteable
    has_many   :comments, :class_name => 'QuestionMod::Comment', :as => :targetable

    has_many :answers, :class_name => 'QuestionMod::Answer', :order => :vote_sum.desc
  end
end
