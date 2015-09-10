module QuestionMod
  class AnswersController < QuestionMod::ApplicationController
    def index
      
    end

    def new
      @answer = QuestionMod::Answer.new
      @question = params[:id]
      p @question
    end

    def create
      @answer = QuestionMod::Answer.new(answer_params)
      if @answer.save
        redirect_to "/questions"
      else
        render :new
      end
    end

    def edit
      @answer = QuestionMod::Answer.find(params[:id])
    end

    def update
      
    end


    private
      def answer_params
        params.require(:answer).permit(:content, :vote_sum, :creator_id, :question_id)
      end
    
  end
end