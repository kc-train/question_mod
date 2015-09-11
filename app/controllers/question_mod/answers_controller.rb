module QuestionMod
  class AnswersController < QuestionMod::ApplicationController
    def index
      
    end

    def new
      @answer = QuestionMod::Answer.new(:question => params[:id])
    end

    def create
      @answer = QuestionMod::Answer.new(answer_params)
      @answer.creator = current_user
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
      @answer = QuestionMod::Answer.find(params[:id])
      @answer.update(answer_params)
      if @answer.save
        redirect_to "/questions"
      else
        render :edit
      end
    end


    private
      def answer_params
        params.require(:answer).permit(:content, :question_id)
      end
    
  end
end