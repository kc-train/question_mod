module QuestionMod
  class QuestionsController < QuestionMod::ApplicationController
    def index
      @questions = QuestionMod::Question.all
    end

    def new
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
        params.require(:question).permit(:title, :content, :vote_sum, :creator_id, :answer_ids => [], answers_attributes:[:id, :content])
      end
    
  end
end