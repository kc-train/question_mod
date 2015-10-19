require 'rails_helper'

RSpec.describe QuestionMod::QuestionVote, type: :model do
  describe "创建6个用户且每个用户各创建一个问题" do
    before{
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @user3 = FactoryGirl.create(:user)
      @user4 = FactoryGirl.create(:user)
      @user5 = FactoryGirl.create(:user)
      @user6 = FactoryGirl.create(:user)
      @question1 = FactoryGirl.create(:question, :title => "w", :creator => @user1)
      @question2 = FactoryGirl.create(:question, :title => "f2", :creator => @user2)
      @question3 = FactoryGirl.create(:question, :title => "3g", :creator => @user3)
      @question4 = FactoryGirl.create(:question, :title => "4d", :creator => @user4)
      @question5 = FactoryGirl.create(:question, :title => "sgf5", :creator => @user5)
      @question6 = FactoryGirl.create(:question, :title => "6gf", :creator => @user6)
    }

    describe "用户3对用户1创建的问题1投赞同票" do
      before{
        @question1.vote_up_by(@user3)
      }
        
      it "投票成功" do
        expect(QuestionMod::Question.find(@question1.id).vote_sum).to eq(1)
        expect(QuestionMod::QuestionVote.count).to eq(1)
      end

      describe "用户3取消对用户1创建的问题1投的赞同票" do
        before{
          @question1.vote_up_by(@user3)
        }

        it "取消成功" do
          expect(QuestionMod::Question.find(@question1.id).vote_sum).to eq(0)
          expect(QuestionMod::QuestionVote.count).to eq(0)
        end
      end

      describe "用户3对用户1创建的问题1投的赞同票修改为反对票" do
        before{
          @question1.vote_down_by(@user3)
        }

        it "修改成功" do
          expect(QuestionMod::Question.find(@question1.id).vote_sum).to eq(-1)
          expect(QuestionMod::QuestionVote.count).to eq(1)
        end
      end
    end

    describe "用户3对用户1创建的问题1投反对票" do
      before{
        @question1.vote_down_by(@user3)
      }

      it "投票成功" do
        expect(QuestionMod::Question.find(@question1.id).vote_sum).to eq(-1)
        expect(QuestionMod::QuestionVote.count).to eq(1)
      end

      describe "用户3取消对用户1创建的问题1投的反对票" do
        before{
          @question1.vote_down_by(@user3)
        }

        it "取消成功" do
          expect(QuestionMod::Question.find(@question1.id).vote_sum).to eq(0)
          expect(QuestionMod::QuestionVote.count).to eq(0)
        end
      end

      describe "用户3对用户1创建的问题1投的反对票修改为赞同票" do
        before{
          @question1.vote_down_by(@user3)
        }

        it "修改成功" do
          expect(QuestionMod::Question.find(@question1.id).vote_sum).to eq(0)
          expect(QuestionMod::QuestionVote.count).to eq(0)
        end
      end
    end

    describe "测试多个用户对问题1投票之后总票数是否符合预期" do
      before{
        @question1.vote_down_by(@user1)
        @question1.vote_up_by(@user2)
        @question1.vote_down_by(@user3)
        @question1.vote_up_by(@user4)
        @question1.vote_up_by(@user5)
        @question1.vote_up_by(@user6)
      }

      it "符合预期" do
        expect(QuestionMod::Question.find(@question1.id).vote_sum).to eq(2)
        expect(QuestionMod::QuestionVote.count).to eq(6)
      end

      describe "测试问题的排序是否符合预期" do
        before{
          @question2.vote_down_by(@user1)
          @question2.vote_up_by(@user2)
          @question2.vote_up_by(@user3)
          @question3.vote_down_by(@user3)
          @question3.vote_up_by(@user4)
          @question4.vote_up_by(@user1)
          @question4.vote_up_by(@user5)
          @question4.vote_up_by(@user6)
          @question5.vote_down_by(@user3)
          @question6.vote_down_by(@user3)
          @question6.vote_down_by(@user4)
        }

        it "符合预期" do
          @questions = QuestionMod::Question.all 
          arr = @questions.map do |question|
            question.title
          end
          expect(arr).to eq(["4d", "w", "f2", "3g", "sgf5", "6gf"])
        end
      end
    end

  end
end
