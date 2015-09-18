module QuestionMod
  class QuestionsController < QuestionMod::ApplicationController
    def index
      @questions = QuestionMod::Question.order(vote_sum: :desc).all
      # @answers = QuestionMod::Answer.order(vote_sum: :desc).all
    end

    def new
      @question = QuestionMod::Question.new
    end

    def create
      @question = QuestionMod::Question.new(question_params)
      @question.creator = current_user
      if @question.save
        redirect_to "/questions"
      else
        render :new
      end
    end

    def method_name
      
    end


    private
      def question_params
        params.require(:question).permit(:title, :content)
      end

  end
end
