require 'rails_helper'

RSpec.describe QuestionMod::Comment, type: :model do
  describe "创建用户1和用户2，用户1创建问题1，用户2对问题1创建回答1" do
    before{
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @question1 = FactoryGirl.create(:question, :creator => @user1)
      @answer1 = FactoryGirl.create(:answer, :creator => @user2, :question => @question1)
    }

    describe "用户2对问题1创建评论" do
      before{
        @question1.comments.create(:content => "122", :creator => @user2)
      }

      it "创建成功" do
        expect(@question1.comments.count).to eq(1)
      end
    end

    describe "用户1对回答1创建评论" do
      before{
        @answer1.comments.create(:content => "122", :creator => @user1)
      }

      it "创建成功" do
        expect(@answer1.comments.count).to eq(1)
      end
    end

    describe "用户1对用户2创建的评论进行回复" do
      before{
        comment1 = @question1.comments.create(:content => "122", :creator => @user2)
        @question1.comments.create(:content => "123", :creator => @user1, :reply_comment => comment1)
      }

      it "创建成功" do
        expect(@question1.comments.count).to eq(2)
      end
    end

    describe "用户2对用户1创建的评论进行回复" do
      before{
        comment1 = @answer1.comments.create(:content => "122", :creator => @user1)
        @answer1.comments.create(:content => "123", :creator => @user2, :reply_comment => comment1)
      }

      it "创建成功" do
        expect(@answer1.comments.count).to eq(2)
      end
    end
  end
end
