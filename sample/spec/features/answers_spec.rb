require 'rails_helper'

RSpec.feature "Answers", type: :feature do
  # before{
  #   @user1 = FactoryGirl.create(:user)
  #   @user2 = FactoryGirl.create(:user)
  #   @question1 = FactoryGirl.create(:question, :creator => @user1)
  # }
  # it "测试用户2对用户1创建的问题1进行回答和对回答的修改成功" do
  #   @answer_content1   = "1"
  #   @answer_content2   = "2"
  #   expect{
  #     #回到首页
  #     login_in(@user2)
  #     click_link "/questions"
  #     #点击回答进入创建回答表单页面，并填入相关信息
  #     click_link "回答"
  #     within(".page-new-answers") do
  #       fill_in "answer[content]",   :with => @answer_content1
  #     end
  #     #点击提交后，问题创建成功并回到问题列表页面
  #     click_button "提交"
  #   #判断回答是否创建成功
  #   }.to change{QuestionMod::Answer.count}.by(1)
  #   #点击修改进入修改回答表单页面，并填入相关信息
  #   click_link "修改"
  #   within(".page-edit-answers") do
  #     fill_in "answer[content]",   :with => @answer_content2
  #   end
  #   #点击提交后，问题修改成功并回到问题列表页面
  #   click_button "提交"
  #   #判断回答是否修改成功
  #   answer = QuestionMod::Answer.all.first
  #   expect(answer.content).to eq(@answer_content2)
  # end
end

