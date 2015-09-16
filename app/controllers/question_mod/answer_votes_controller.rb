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

    def edit
      @answer_vote = QuestionMod::AnswerVote.find(params[:id])
    end

    def update
      @answer_vote = QuestionMod::AnswerVote.find(params[:id])
      @answer_vote.update(answer_vote_params)
      if @answer_vote.save
        redirect_to "/questions"
      else
        render :edit
      end
    end

    def destroy
      @answer_vote = QuestionMod::AnswerVote.find(params[:id])
      @answer_vote.destroy
      redirect_to "/questions"
    end

    private
      def answer_vote_params
        params.require(:answer_vote).permit(:kind, :answer_id)
      end
  end
end