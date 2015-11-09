module QuestionMod
  class Comment
    include Mongoid::Document
    include Mongoid::Timestamps

    field :content, :type => String

    after_create :comment_created

    validates :content, :presence => true
    validates :creator, :presence => true

    belongs_to :creator,  :class_name => 'User'
    belongs_to :targetable, :polymorphic => true

    belongs_to :reply_comment, :class_name => "QuestionMod::Comment"

    private
      def comment_created
        if self.targetable_type == "QuestionMod::Question"
          if self.reply_comment == nil
            user = self.targetable.creator
            user.notifications.create(:kind => "question", :info => {:str1 => "您的问题", :question_title => self.targetable.title, :str2 => "收到一个新的评论"})
          else
            user = self.reply_comment.creator
            user.notifications.create(:kind => "question", :info => {:str1 => "您在问题", :question_title => self.targetable.title, :str2 => "下的评论收到一个新的回复"})
          end
        end

        if self.targetable_type == "QuestionMod::Answer"  
          if self.reply_comment.blank?
            user = self.targetable.creator
            user.notifications.create(:kind => "question", :info => {:str1 => "您在问题", :question_title => self.targetable.question.title, :str2 => "下的回答收到一个新的评论"})
          else
            user = self.reply_comment.creator
            user.notifications.create(:kind => "question", :info => {:str1 => "您在问题", :question_title => self.targetable.question.title, :str2 => "下的评论收到一个新的回复"})
          end
        end
      end
  end
end
