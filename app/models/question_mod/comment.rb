module QuestionMod
  class Comment
    include Mongoid::Document
    include Mongoid::Timestamps

    field :content, :type => String

    validates :content, :presence => true
    validates :creator, :presence => true

    belongs_to :creator,  :class_name => 'User'
    belongs_to :targetable, :polymorphic => true

    belongs_to :reply_comment, :class_name => "QuestionMod::Comment"
  end
end
