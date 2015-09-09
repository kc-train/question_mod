module QuestionMod
  class QuestionsController < QuestionMod::ApplicationController
    def index
      
    end

    def new
      # current_user = @current_user
      @question = QuestionMod::Question.new
    end

    def create
      @question = QuestionMod::Question.new(question_params)
      if @question.save
        redirect_to "/questions"
      else
        render :new
      end
    end


    private
      def question_params
        params.require(:question).permit(:title, :content, :vote_sum)
      end
    
  end
end