require 'rails_helper'

RSpec.feature "QuestionVotes", type: :feature do
  # it "用户2对用户1创建的问题1进行投票和对投票的修改和取消" do
  #   @question_title   = "加法"
  #   @question_content = "1 + 1 = ?"
  #   @user1 = create(:user)
  #   @user2 = create(:user)
  #   login_in(@user1)
  #   visit "/questions"
  #   #点击提问进入创建问题表单页面，并填入相关信息
  #   click_link "提问"
  #   within(".page-new-questions") do
  #     fill_in "question[title]",   :with => @question_title
  #     fill_in "question[content]", :with => @question_content
  #   end
  #   #点击提交后，问题创建成功并回到问题列表页面
  #   click_button "提交"
  #   #用户2登录并投票
  #   expect{
  #     login_in(@user2)
  #     visit "/questions"
  #     #点击赞同按钮，投赞同票
  #     click_link "赞同"
  #     #进入投票页面，选择up，点击确定
  #     within(".page-new-question-votes") do
  #       choose("Up")
  #     end
  #     click_button "确定"
  #   #判断是否投票成功
  #   }.to change{QuestionMod::QuestionVote.count}.by(1)
  #   #判断是否为赞同票
  #   question = QuestionMod::Question.all.first
  #   expect(question.vote_sum).to eq(1)
  #   #回问题列表页面，点击修改投票
  #   click_link "修改投票"
  #   #进入修改投票页面，选择down，点击确定
  #   within(".page-edit-question-votes") do
  #     choose("Down")
  #   end
  #   click_button "确定"
  #   #判断赞同票是否变为反对票
  #   question = QuestionMod::Question.all.first
  #   expect(question.vote_sum).to eq(-1)
  #   #回问题列表页面，点击取消投票
  #   expect{
  #     click_link "取消投票"
  #   #判断投票是否被取消
  #   }.to change{QuestionMod::QuestionVote.count}.by(-1)
  #   question = QuestionMod::Question.all.first
  #   expect(question.vote_sum).to eq(0)
  #   expect{
  #     #点击反对按钮，投反对票
  #     click_link "反对"
  #     #进入投票页面，选择down，点击确定
  #     within(".page-new-question-votes") do
  #       choose("Down")
  #     end
  #     click_button "确定"
  #   #判断是否投票成功
  #   }.to change{QuestionMod::QuestionVote.count}.by(1)
  #   #判断是否为反对票
  #   question = QuestionMod::Question.all.first
  #   expect(question.vote_sum).to eq(-1)
  # end
end
