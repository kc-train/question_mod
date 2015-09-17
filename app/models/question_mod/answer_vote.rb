module QuestionMod
  class AnswerVote
    extend Enumerize
    KIND_UP   = 'up'
    KIND_DOWN = 'down'

    include Mongoid::Document
    include Mongoid::Timestamps

    # up down 二选一
    enumerize :kind, in: [:up, :down]
    validates :creator, :presence => true
    validates :answer, :presence => true


    after_create :create_vote
    before_update :update_vote
    before_destroy :destroy_vote

    # creator 不能为空
    belongs_to :creator, :class_name => 'User'
    # answer 不能为空
    belongs_to :answer, :class_name => 'QuestionMod::Answer'

    protected
      def change_answer_vote_sum(change_count)
        self.answer.set(:vote_sum => self.answer.vote_sum + change_count)
      end

      def create_vote
        if self.kind == KIND_UP
          change_answer_vote_sum 1
        elsif self.kind == KIND_DOWN
          change_answer_vote_sum -1
        end 
      end

      def update_vote
        kinds = self.changes["kind"]
        if kinds == [KIND_UP,KIND_DOWN]
          change_answer_vote_sum -2
        elsif kinds == [KIND_DOWN,KIND_UP]
          change_answer_vote_sum 2
        end 
      end

      def destroy_vote
        if self.kind == KIND_UP
          change_answer_vote_sum -1
        elsif self.kind == KIND_DOWN
          change_answer_vote_sum 1
        end
      end
  end
end