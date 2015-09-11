module QuestionMod
  class QuestionsController < QuestionMod::ApplicationController
    def index
      # @agree_vote = @question.question_vote.where(:kind => :up).count
      # @against_vote = @question.question_vote.where(:kind => :down).count
      # @vote_sum = @agree_vote - @against_vote
      # @question = QuestionMod::Question.new(:vote_sum => @vote_sum)
      @questions = QuestionMod::Question.all
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


    private
      def question_params
        params.require(:question).permit(:title, :content)
      end

  end
end
