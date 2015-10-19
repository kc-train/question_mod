require 'rails_helper'

RSpec.describe QuestionMod::AnswerVote, type: :model do
  describe "创建6个用户且由用户1创建一个问题，剩余5个用户对该问题各创建一个答案" do
    before{
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @user3 = FactoryGirl.create(:user)
      @user4 = FactoryGirl.create(:user)
      @user5 = FactoryGirl.create(:user)
      @user6 = FactoryGirl.create(:user)
      @question1 = FactoryGirl.create(:question, :creator => @user1)
      @answer1 = FactoryGirl.create(:answer, :content => "1", :creator => @user2, :question => @question1)
      @answer2 = FactoryGirl.create(:answer, :content => "2", :creator => @user3, :question => @question1)
      @answer3 = FactoryGirl.create(:answer, :content => "3", :creator => @user4, :question => @question1)
      @answer4 = FactoryGirl.create(:answer, :content => "4", :creator => @user5, :question => @question1)
      @answer5 = FactoryGirl.create(:answer, :content => "5", :creator => @user6, :question => @question1)
    }
   
    describe "用户5对用户2创建的回答1投赞同票" do
      before{
        @answer1.vote_up_by(@user5)
      }
      
      it "投票成功" do
        expect(QuestionMod::Answer.find(@answer1.id).vote_sum).to eq(1)
        expect(QuestionMod::AnswerVote.count).to eq(1)
      end

      describe "用户5取消对用户2创建的回答1投的赞同票" do
        before{
          @answer1.vote_up_by(@user5)
        }

        it "取消成功" do
          expect(QuestionMod::Answer.find(@answer1.id).vote_sum).to eq(0)
          expect(QuestionMod::AnswerVote.count).to eq(0)
        end
      end

      describe "用户5对用户2创建的回答1投的赞同票修改为反对票" do
        before{
          @answer1.vote_down_by(@user5)
        }

        it "修改成功" do
          expect(QuestionMod::Answer.find(@answer1.id).vote_sum).to eq(-1)
          expect(QuestionMod::AnswerVote.count).to eq(1)
        end
      end
    end

    
    describe "用户3对用户2创建的回答1投反对票" do
      before{
        @answer1.vote_down_by(@user3)
      }

      it "投票成功" do
        expect(QuestionMod::Answer.find(@answer1.id).vote_sum).to eq(-1)
        expect(QuestionMod::AnswerVote.count).to eq(1)
      end

      describe "用户5取消对用户2创建的回答1投的反对票" do
        before{
          @answer1.vote_down_by(@user3)
        }

        it "取消成功" do
          expect(QuestionMod::Answer.find(@answer1.id).vote_sum).to eq(0)
          expect(QuestionMod::AnswerVote.count).to eq(0)
        end
      end

      describe "用户5对用户2创建的回答1投的反对票修改为赞同票" do
        before{
          @answer1.vote_up_by(@user3)
        }

        it "取消成功" do
          expect(QuestionMod::Answer.find(@answer1.id).vote_sum).to eq(1)
          expect(QuestionMod::AnswerVote.count).to eq(1)
        end
      end
    end

    describe "测试多个用户对回答1投票之后总票数是否符合预期" do
      before{
        @answer1.vote_down_by(@user3)
        @answer1.vote_up_by(@user5)
        @answer1.vote_down_by(@user6)
      }

      it "符合预期" do
        expect(QuestionMod::Answer.find(@answer1.id).vote_sum).to eq(-1)
        expect(QuestionMod::AnswerVote.count).to eq(3)
      end
    end

    describe "回答的排序是否符合预期" do
      before{
        @answer1.vote_up_by(@user5)
        @answer2.vote_up_by(@user5)
        @answer2.vote_up_by(@user1)
        @answer3.vote_down_by(@user6)
        @answer3.vote_down_by(@user1)
        @answer4.vote_down_by(@user1)
      }
      
      it "符合预期" do
        arr = @question1.answers.map do |answer|
          answer.content
        end
        expect(arr).to eq(["2", "1", "5", "4", "3"])
      end
    end
  end
end
