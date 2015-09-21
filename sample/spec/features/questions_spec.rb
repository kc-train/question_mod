require 'rails_helper'

RSpec.describe "Questions", type: :feature do

  # it "测试用户创建问题成功" do
  #   @question_title    = "加法"
  #   @question_content  = "1 + 1 = ?"
  #   expect{
  #     user = create(:user)
  #     login_in(user)
  #     visit "/questions"
  #     #点击提问进入创建问题表单页面，并填入相关信息
  #     click_link "提问"
  #     within(".page-new-questions") do
  #       fill_in "question[title]",   :with => @question_title
  #       fill_in "question[content]", :with => @question_content
  #     end
  #     #点击提交后，问题创建成功并回到问题列表页面
  #     click_button "提交"
  #     expect(page).to have_css ".page-questions-index"
  #   #判断问题是否创建成功
  #   }.to change{QuestionMod::Question.count}.by(1)
  # end
end
