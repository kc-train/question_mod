module QuestionMod
  class AnswerVotesController < QuestionMod::ApplicationController
    def index
      
    end

    def new
      @answer_vote = QuestionMod::AnswerVote.new(:answer => params[:id])
    end

    def create
      @answer_vote = QuestionMod::AnswerVote.new(answer_vote_params)
      @answer_vote.creator = current_user
      if @answer_vote.save
        redirect_to "/questions"
      else
        render :new
      end
    end

    def destroy

    end

    private
      def answer_vote_params
        params.require(:answer_vote).permit(:kind, :answer_id)
      end
  end
end