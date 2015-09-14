module QuestionMod
  class QuestionVotesController < QuestionMod::ApplicationController
    def index
    end

    def new
      @question_vote = QuestionMod::QuestionVote.new(:question => params[:id])
    end

    def create
      @question_vote = QuestionMod::QuestionVote.new(question_vote_params)
      @question_vote.creator = current_user
      if @question_vote.save
        redirect_to "/questions"
      else
        render :new
      end
    end

    def destroy
      @question_vote = QuestionMod::QuestionVote.where(:question_id => params[:id],:creator => current_user)
      @question.destroy
      redirect_to "/questions"
    end

    private
      def question_vote_params
        params.require(:question_vote).permit(:kind, :question_id)
      end
  end
end