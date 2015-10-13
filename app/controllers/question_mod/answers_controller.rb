module QuestionMod
  class AnswersController < QuestionMod::ApplicationController
    before_action :find_question
    def index
      @answers = QuestionMod::Answer.order(vote_sum: :desc).all
      @answer = @question.answers.new
    end

    def new
      @answer = @question.answers.new
    end

    def create
      @answer = @question.answers.create(answer_params)
      @answer.creator = current_user
      if @answer.save
        redirect_to "/questions/#{@question.id}/answers"
      else
        render :new
      end
    end

    def update
      @answer = @question.answers.find(params[:id])
      @answer.update(answer_params)
      if @answer.save
        redirect_to "/questions/#{@question.id}/answers"
      end
    end

    def vote_up
      @answer = QuestionMod::Answer.find(params[:id])
      p @answer.content
      @answer.vote_up_by(current_user)
      @answer.reload
      render :json => {
        :state    => @answer.vote_state_of(current_user),
        :vote_sum => @answer.vote_sum
      }
    end

    def vote_down
      @answer = QuestionMod::Answer.find(params[:id])
      p @answer.content
      @answer.vote_down_by(current_user)
      p @answer.vote_sum
      @answer.reload
      p @answer.vote_sum
      render :json => {
        :state    => @answer.vote_state_of(current_user),
        :vote_sum => @answer.vote_sum
      }
    end


    private
      def find_question
        @question = Question.find(params[:question_id])
      end

      def answer_params
        params.require(:answer).permit(:content)
      end
  end
end