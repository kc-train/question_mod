module QuestionMod
  class QuestionVote
    extend Enumerize
    KIND_UP   = 'up'
    KIND_DOWN = 'down'

    include Mongoid::Document
    include Mongoid::Timestamps

    # up down 二选一
    enumerize :kind, in: [KIND_UP, KIND_DOWN]
    validates :creator, :presence => true
    validates :question, :presence => true

    after_create :create_vote
    before_update :update_vote
    before_destroy :destroy_vote

    # # creator 不能为空
    belongs_to :creator,  :class_name => 'User'
    #
    # # question 不能为空
    belongs_to :question, :class_name => 'QuestionMod::Question'

    protected
      def change_question_vote_sum(change_count)
        self.question.set(:vote_sum => self.question.vote_sum + change_count)
      end


      def create_vote
        if self.kind == KIND_UP
          change_question_vote_sum 1
        elsif self.kind == KIND_DOWN
          change_question_vote_sum -1
        end
      end

      def update_vote
        kinds = self.changes["kind"]
        if kinds == [KIND_UP,KIND_DOWN]
          change_question_vote_sum -2
        elsif kinds == [KIND_DOWN,KIND_UP]
          change_question_vote_sum 2
        end
      end

      def destroy_vote
        if self.kind == KIND_UP
          change_question_vote_sum -1
        elsif self.kind == KIND_DOWN
          change_question_vote_sum 1
        end
      end
  end
end
