module QuestionMod
  class AnswersController < QuestionMod::ApplicationController
    def index
      
    end

    def new
      # current_user = @current_user
      @answer = QuestionMod::Answer.new
    end

    def create
      @answer = QuestionMod::Answer.new(answer_params)
      if @answer.save
        redirect_to "/answers"
      else
        render :new
      end
    end


    private
      def answer_params
        params.require(:answer).permit(:content, :vote_sum)
      end
    
  end
end