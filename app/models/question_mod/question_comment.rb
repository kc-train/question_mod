module QuestionMod
  class QuestionComment
    include Mongoid::Document
    include Mongoid::Timestamps
    
    field :content, :type => String

    validates :content, :presence => true
    validates :creator, :presence => true
    validates :question, :presence => true

    belongs_to :creator,  :class_name => 'User'
    belongs_to :question, :class_name => 'QuestionMod::Question'
  end
end