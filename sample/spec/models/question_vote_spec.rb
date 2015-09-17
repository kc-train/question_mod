require 'rails_helper'

RSpec.describe QuestionMod::QuestionVote, type: :model do
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
    @question_vote2_1 = FactoryGirl.create(:question_vote, :creator => @user2, :question => @question1)
    @question_vote4_1 = FactoryGirl.create(:question_vote, :kind => :down, :creator => @user4, :question => @question1)
  }
  it "测试用户3对用户1创建的问题1投赞同票成功" do
    expect{
      expect{
        question_vote3_1 = FactoryGirl.create(:question_vote, :creator => @user3, :question => @question1)
      }.to change{@question1.vote_sum}.by(1)
    }.to change{QuestionMod::QuestionVote.count}.by(1)
  end

  it "测试用户3对用户1创建的问题1投反对票成功" do
    expect{
      expect{
        question_vote3_1 = FactoryGirl.create(:question_vote, :kind => :down, :creator => @user3, :question => @question1)
      }.to change{@question1.vote_sum}.by(-1)
    }.to change{QuestionMod::QuestionVote.count}.by(1)
  end

  it "测试用户2对用户1创建的问题1投的赞同票取消成功" do
    expect{
      expect{
        @question_vote2_1.destroy
      }.to change{@question1.vote_sum}.by(-1)
    }.to change{QuestionMod::QuestionVote.count}.by(-1)
  end

  it "测试用户4对用户1创建的问题1投的反对票取消成功" do
    expect{
      expect{
        @question_vote4_1.destroy
      }.to change{@question1.vote_sum}.by(1)
    }.to change{QuestionMod::QuestionVote.count}.by(-1)
  end

  it "测试用户2对用户1创建的问题1投的赞同票修改为反对票成功" do
    expect{
      expect{
        @question_vote2_1.update(:kind => :down)
      }.to change{@question1.vote_sum}.by(-2)
    }.to change{QuestionMod::QuestionVote.count}.by(0)
  end

  it "测试用户4对用户1创建的问题1投的反对票修改为赞同票成功" do
    expect{
      expect{
        @question_vote4_1.update(:kind => :up)
      }.to change{@question1.vote_sum}.by(2)
    }.to change{QuestionMod::QuestionVote.count}.by(0)
  end

  it "测试多个用户对问题1投票之后总票数是否符合预期" do
    expect{
      question_vote3_1 = FactoryGirl.create(:question_vote, :kind => :down, :creator => @user3, :question => @question1)
      question_vote5_1 = FactoryGirl.create(:question_vote, :creator => @user5, :question => @question1)
      question_vote6_1 = FactoryGirl.create(:question_vote, :kind => :down, :creator => @user6, :question => @question1)
    }.to change{@question1.vote_sum}.by(-1)
  end

  it "问题的排序是否符合预期" do
    @question_vote2_1.update(:kind => :down)
    question_vote3_1 = FactoryGirl.create(:question_vote, :creator => @user3, :question => @question1)
    @question_vote4_1.destroy
    question_vote5_1 = FactoryGirl.create(:question_vote, :creator => @user5, :question => @question1)
    question_vote6_1 = FactoryGirl.create(:question_vote, :kind => :down, :creator => @user6, :question => @question1)
    question_vote1_2 = FactoryGirl.create(:question_vote, :creator => @user1, :question => @question2)
    question_vote3_2 = FactoryGirl.create(:question_vote, :creator => @user3, :question => @question2)
    question_vote4_2 = FactoryGirl.create(:question_vote, :creator => @user4, :question => @question2)
    question_vote5_2 = FactoryGirl.create(:question_vote, :creator => @user5, :question => @question2)
    question_vote6_2 = FactoryGirl.create(:question_vote, :creator => @user6, :question => @question2)
    @questions = QuestionMod::Question.order(vote_sum: :desc).all
    p @question2.vote_sum
    p QuestionMod::Question.all.distinct("title").order(vote_sum: :desc)
    # expect(@questions.distinct("title")).to eq(["1", "2", "3", "4", "5", "6"])
  end
end
