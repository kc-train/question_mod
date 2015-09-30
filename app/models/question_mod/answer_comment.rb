module QuestionMod
  class AnswerComment
    include Mongoid::Document
    include Mongoid::Timestamps
    
    field :content, :type => String

    validates :content, :presence => true, :uniqueness => true
    validates :creator, :presence => true
    validates :answer, :presence => true

    belongs_to :creator,  :class_name => 'User'
    belongs_to :answer, :class_name => 'QuestionMod::Answer'
  end
end