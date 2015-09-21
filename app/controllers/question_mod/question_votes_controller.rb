module QuestionMod
  class QuestionVotesController < QuestionMod::ApplicationController
    before_action :find_question
    def index
    end

    def agree
      if @question.vote_state_of(current_user) == QuestionMod::QuestionVote::KIND_UP
        @question.vote_by(current_user,"")
      else
        @question.vote_by(current_user,QuestionMod::QuestionVote::KIND_UP)
      end
      redirect_to "/questions"
    end

    def against
      if @question.vote_state_of(current_user) == QuestionMod::QuestionVote::KIND_DOWN
        @question.vote_by(current_user,"")
      else
        @question.vote_by(current_user,QuestionMod::QuestionVote::KIND_DOWN)
      end
      redirect_to "/questions"
    end

    private
      def find_question
        @question = QuestionMod::Question.find(params[:question_id])
        @question_id = params[:question_id]
      end
  end
end