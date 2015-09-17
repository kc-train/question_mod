require 'rails_helper'

RSpec.describe QuestionMod::AnswerVote, type: :model do
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
    @answer_vote1_1 = FactoryGirl.create(:answer_vote, :creator => @user1, :answer => @answer1)
    @answer_vote4_1 = FactoryGirl.create(:answer_vote, :kind => :down, :creator => @user4, :answer => @answer1)
  }
  it "测试用户1对用户2创建的回答1投赞同票成功" do
    expect{
      expect{
        answer_vote1_1 = FactoryGirl.create(:answer_vote, :creator => @user1, :answer => @answer1)
      }.to change{@answer1.vote_sum}.by(1)
    }.to change{QuestionMod::AnswerVote.count}.by(1)
  end

  it "测试用户3对用户2创建的回答1投反对票成功" do
    expect{
      expect{
        answer_vote3_1 = FactoryGirl.create(:answer_vote, :kind => :down, :creator => @user3, :answer => @answer1)
      }.to change{@answer1.vote_sum}.by(-1)
    }.to change{QuestionMod::AnswerVote.count}.by(1)
  end

  it "测试用户1对用户2创建的回答1投的赞同票取消成功" do
    expect{
      expect{
        @answer_vote1_1.destroy
      }.to change{@answer1.vote_sum}.by(-1)
    }.to change{QuestionMod::AnswerVote.count}.by(-1)
  end

  it "测试用户4对用户1创建的问题1投的反对票取消成功" do
    expect{
      expect{
        @answer_vote4_1.destroy
      }.to change{@answer1.vote_sum}.by(1)
    }.to change{QuestionMod::AnswerVote.count}.by(-1)
  end

  it "测试用户1对用户1创建的问题1投的赞同票修改为反对票成功" do
    expect{
      expect{
        @answer_vote1_1.update(:kind => :down)
      }.to change{@answer1.vote_sum}.by(-2)
    }.to change{QuestionMod::AnswerVote.count}.by(0)
  end

  it "测试用户4对用户1创建的问题1投的反对票修改为赞同票成功" do
    expect{
      expect{
        @answer_vote4_1.update(:kind => :up)
      }.to change{@answer1.vote_sum}.by(2)
    }.to change{QuestionMod::AnswerVote.count}.by(0)
  end

  it "测试多个用户对回答1投票之后总票数是否符合预期" do
    expect{
      answer_vote3_1 = FactoryGirl.create(:answer_vote, :kind => :down, :creator => @user3, :answer => @answer1)
      answer_vote5_1 = FactoryGirl.create(:answer_vote, :creator => @user5, :answer => @answer1)
      answer_vote6_1 = FactoryGirl.create(:answer_vote, :kind => :down, :creator => @user6, :answer => @answer1)
    }.to change{@answer1.vote_sum}.by(-1)
  end

  it "问题的排序是否符合预期" do
    @answers = QuestionMod::Answer.order(vote_sum: :desc).all
    expect(@answers.distinct("content")).to eq(["1", "2", "3", "4", "5"])
  end
end
