require 'rails_helper'

RSpec.describe User, type: :model do
  it "测试用户字段完全通过校验" do
    user = User.new(:name => "gff", :email =>  "504371515@qq.com", :password => "123456")
    expect(user).to be_valid
  end

  describe "创建用户1,2,3,4" do
    before{
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @user3 = FactoryGirl.create(:user)
      @user4 = FactoryGirl.create(:user)
      @question1 = FactoryGirl.create(:question, :creator => @user1)
      @question2 = FactoryGirl.create(:question, :creator => @user1)
      @question3 = FactoryGirl.create(:question, :creator => @user1)
      @question4 = FactoryGirl.create(:question, :creator => @user1)
      @question5 = FactoryGirl.create(:question, :creator => @user2)
      @question6 = FactoryGirl.create(:question, :creator => @user2)
      @question7 = FactoryGirl.create(:question, :creator => @user2)
      @question8 = FactoryGirl.create(:question, :creator => @user3)
      @question9 = FactoryGirl.create(:question, :creator => @user3)
      @question10 = FactoryGirl.create(:question, :creator => @user4)
    }

    it{
      answer2_1 = @user2.answers.create(:content => "123", :question => @question1)
      answer3_1 = @user3.answers.create(:content => "123", :question => @question1)
      answer4_1 = @user4.answers.create(:content => "123", :question => @question1)
      answer2_2 = @user2.answers.create(:content => "123", :question => @question2)
      answer1_5 = @user1.answers.create(:content => "123", :question => @question5)
      answer4_5 = @user4.answers.create(:content => "123", :question => @question5)
      answer1_8 = @user1.answers.create(:content => "123", :question => @question8)
      answer3_10 = @user3.answers.create(:content => "123", :question => @question10)
      @question1.vote_up_by(@user3)
      @question1.vote_up_by(@user2)
      @question2.vote_up_by(@user2)
      @question8.vote_down_by(@user1)
      @question10.vote_down_by(@user1)
      @question10.vote_down_by(@user2)
      @question3.vote_up_by(@user3)
      @question3.vote_up_by(@user2)
      @question4.vote_up_by(@user3)
      @question7.vote_down_by(@user1)
      @question9.vote_down_by(@user1)
      @question9.vote_down_by(@user2)

      expect(QuestionMod::Question.answered).to eq([@question1, @question2, @question5, @question8, @question10])
      expect(QuestionMod::Question.unanswered).to eq([@question3, @question4, @question6, @question7, @question9])
      expect(@user1.answered_questions.class.name).to eq('Mongoid::Criteria')
      expect(@user1.answered_questions.first).to eq(@question5)
      expect(@user1.answered_questions.last).to eq(@question8)
      expect(@user1.answered_questions.count).to eq(2)
      expect(@user3.created_questions.class.name).to eq('Mongoid::Relations::Targets::Enumerable')
      expect(@user3.created_questions.first).to eq(@question8)
      expect(@user3.created_questions.last).to eq(@question9)
      expect(@user3.created_questions.count).to eq(2)
    }
  end
end
