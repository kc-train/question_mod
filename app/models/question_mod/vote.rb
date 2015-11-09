module QuestionMod
  class Vote
    extend Enumerize
    KIND_UP   = 'up'
    KIND_DOWN = 'down'

    include Mongoid::Document
    include Mongoid::Timestamps


    # up down 二选一
    enumerize :kind, in: [:up, :down]
    validates :creator, :presence => true

    after_create :vote_created
    before_update :update_vote
    before_destroy :destroy_vote

    # creator 不能为空
    belongs_to :creator, :class_name => 'User'
    belongs_to :voteable, :polymorphic => true

    private
      def change_vote_sum(change_count)
        self.voteable.set(:vote_sum => self.voteable.vote_sum + change_count)
      end

      def vote_created
        user = self.voteable.creator
        
        if self.kind == KIND_UP
          change_vote_sum 1

          if self.voteable_type == "QuestionMod::Answer"
            user.notifications.create(:kind => "question", :info => {:str1 => "您在问题", :question_title => self.voteable.question.title, :str2 => "的回答获得了一次赞"})
          end

          if self.voteable_type == "QuestionMod::Question"
            user.notifications.create(:kind => "question", :info => {:str1 => "您的问题", :question_title => self.voteable.title, :str2 => "获得了一次赞"})
          end

        elsif self.kind == KIND_DOWN
          change_vote_sum -1

          if self.voteable_type == "QuestionMod::Answer"
            user.notifications.create(:kind => "question", :info => {:str1 => "您在问题", :question_title => self.voteable.question.title, :str2 => "的回答获得了一次踩"})
          end

          if self.voteable_type == "QuestionMod::Question" 
            user.notifications.create(:kind => "question", :info => {:str1 => "您的问题", :question_title => self.voteable.title, :str2 => "获得了一次踩"})
          end
          
        end 
      end

      def update_vote
        kinds = self.changes["kind"]
        if kinds == [KIND_UP,KIND_DOWN]
          change_vote_sum -2
        elsif kinds == [KIND_DOWN,KIND_UP]
          change_vote_sum 2
        end 
      end

      def destroy_vote
        if self.kind == KIND_UP
          change_vote_sum -1
        elsif self.kind == KIND_DOWN
          change_vote_sum 1
        end
      end  
  end
end