module QuestionMod
  class AnswerCommentsController < QuestionMod::ApplicationController
    before_action :find_answer
    before_action :find_question
    def index
      
    end
    
    def new
      @answer_comment = @answer.answer_comments.new
    end

    def create
      @answer_comment = @answer.answer_comments.create(answer_comment_params)
      @answer_comment.creator = current_user
      if @answer_comment.save
        redirect_to "question/#{@question.id}/answer"
      end
    end

    def destroy
      @answer_comment.destroy
    end

    private
      def find_question
        @question = Question.find(params[:question_id])
        @question_id = params[:question_id]
      end

      def answer_comment_params  
        params.require(:answer_comment).permit(:content)
      end

      def find_answer
        @answer = Answer.find(params[:answer_id])
        @answer_id = params[:answer_id]
      end
  end
end