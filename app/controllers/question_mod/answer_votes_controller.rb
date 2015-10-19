module QuestionMod
  class AnswerVotesController < QuestionMod::ApplicationController
    before_action :find_answer
    def index
      
    end
   
    def agree
      if @answer.vote_state_of(current_user) == QuestionMod::QuestionVote::KIND_UP
        @answer.vote_by(current_user,"")
      else
        @answer.vote_by(current_user,QuestionMod::QuestionVote::KIND_UP)
      end
      redirect_to "/questions/#{@answer.question.id}"
    end

    def against
      if @answer.vote_state_of(current_user) == QuestionMod::QuestionVote::KIND_DOWN
        @answer.vote_by(current_user,"")
      else
        @answer.vote_by(current_user,QuestionMod::QuestionVote::KIND_DOWN)
      end
      redirect_to "/questions/#{@answer.question.id}"
    end

    private
      def find_answer
        @answer = Answer.find(params[:answer_id])
        @answer_id = params[:answer_id]
      end
  end
end