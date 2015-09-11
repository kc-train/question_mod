module QuestionMod
  class QuestionVotesController < QuestionMod::ApplicationController
    def index
      
    end

    def new
      @question_vote = QuestionMod::QuestionVote.new(:question => params[:id])
    end

    def create
      kind = params[:kind]
      p kind
      @question_vote = QuestionMod::QuestionVote.new(question_vote_params)
      @question_vote.creator = current_user
      if @question_vote.save
        redirect_to "/questions"
      else
        render :new
      end
    end

    def destroy

    end

    private
      def question_vote_params
        params.require(:question_vote).permit(:kind, :question_id)
      end
  end
end