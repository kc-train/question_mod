require 'rails_helper'

RSpec.feature "AnswerVotes", type: :feature do
  # before{
  #   @user1 = FactoryGirl.create(:user)
  #   @user2 = FactoryGirl.create(:user)
  #   @user3 = FactoryGirl.create(:user)
  #   @question1 = FactoryGirl.create(:question, :title => "w", :creator => @user1)
  #   @answer1 = FactoryGirl.create(:answer, :content => "1", :creator => @user2, :question => @question1)
  #   # @answer_vote3_1 = FactoryGirl.create(:answer_vote, :creator => @user3, :answer => @answer1)
  # }

  # it "测试用户1对用户2对问题1的回答进行投赞同票" do
  #   login_in(@user1)
  #   click_link "/questions"
  #   #点击赞同按钮，投赞同票
  #   first("a.answer-agree-vote").click
  #   #判断是否投票成功
  #   expect(@answer1.vote_sum).to eq(1)
  # end

  # it "测试用户1对用户2对问题1的回答进行投反对票" do
  #   login_in(@user1)
  #   click_link "/questions"
  #   #点击反对按钮，投反对票
  #   first("a.answer-against-vote").click
  #   # click_link "反对"
  #   #判断是否投票成功
  #   expect(@answer1.vote_sum).to eq(-1)
  # end

  # it "测试用户3对用户2对问题1的回答的赞同票修改为反对票" do
  #   login_in(@user3)
  #   visit "/questions"
  #   expect{
  #     #点击反对按钮，修改投票
  #     click_link "反对"
  #   #判断是否修改投票成功
  #   }.to change{QuestionMod::AnswerVote.count}.by(0)
  #   #判断是否为反对票
  #   answer = QuestionMod::Answer.all.first
  #   expect(answer.vote_sum).to eq(1)
  # end

  # it "测试用户3对用户2对问题1的回答的赞同票取消" do
  #   login_in(@user3)
  #   visit "/questions"
  #   expect{
  #     #点击赞同按钮，取消投票
  #     click_link "赞同"
  #   #判断是否取消投票成功
  #   }.to change{QuestionMod::AnswerVote.count}.by(-1)
  #   answer = QuestionMod::Answer.all.first
  #   expect(answer.vote_sum).to eq(0)
  # end

end
