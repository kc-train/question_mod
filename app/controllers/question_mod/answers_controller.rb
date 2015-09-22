module QuestionMod
  class AnswersController < QuestionMod::ApplicationController
    before_action :find_question
    def index
      @answers = QuestionMod::Answer.order(vote_sum: :desc).all
    end

    def new
      @answer = @question.answers.new
    end

    def create
      @answer = @question.answers.create(answer_params)
      @answer.creator = current_user
      if @answer.save
        redirect_to "/questions"
      else
        render :new
      end
    end

    def edit
      @answer = @question.answers.find(params[:id])
    end

    def update
      @answer = @question.answers.find(params[:id])
      @answer.update(answer_params)
      if @answer.save
        redirect_to "/questions"
      else
        render :edit
      end
    end


    private
      def find_question
        @question = Question.find(params[:question_id])
        @question_id = params[:question_id]
      end

      def answer_params
        params.require(:answer).permit(:content)
      end
  end
end