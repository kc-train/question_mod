module QuestionMod
  class QuestionCommentsController < QuestionMod::ApplicationController
    before_action :find_question
    def index
    end

    def new
      @question_comment = @question.comments.new
    end

    def create
      comment = @question.comments.create(question_comment_params)
      comment.creator = current_user
      if comment.save
        html = render_to_string :partial => "/question_mod/question_comments/comment_li", :locals => {:comment => comment}
        return render :text => html
      end
      render :status => 500
    end

    def destroy
      @question_comment = QuestionMod::Comment.find(params[:id])
      @question_comment.destroy
      redirect_to "/questions/#{@question_id}/answers"
    end

    private

      def question_comment_params
        params.require(:comment).permit(:content, :question_comment_id)
      end

      def find_question
        @question = QuestionMod::Question.find(params[:question_id])
      end
  end
end
