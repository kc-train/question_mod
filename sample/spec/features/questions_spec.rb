require 'rails_helper'

RSpec.feature "Questions", type: :feature do
  it "测试用户创建问题成功" do
    expect{
      @user_name1 = "用户1"
      @email1     = "147258369@qq.com"
      @password1  = "zjb5363883"
      @question_title   = "加法"
      @question_content = "1 + 1 = ?"
      visit "/"
      #点击注册
      first("a.create-user").click
      #进入注册页面，填入相关信息点击提交
      within(".page-container") do
        fill_in "用户名",   :with => @user_name1
        fill_in "Email",    :with => @email1
        fill_in "密码",     :with => @password1
        fill_in "密码验证", :with => @password1
      end
      click_button '提交'
      #注册成功回到首页，点击登录
      first("a.log-in").click
      #进入登录页面，填入正确的邮箱和密码，点击提交
      within(".page-container") do
        fill_in "Email",    :with => @email1
        fill_in "密码",     :with => @password1
      end
      click_button '提交'
      #回到首页，并显示当前用户
      expect(page).to have_css ".desc.current-user"
      #点击提问进入问题列表页面
      first("a.to-questions").click
      #点击提问进入创建问题表单页面，并填入相关信息
      click_link "提问"
      within(".page-new-questions") do
        fill_in "question[title]",   :with => @question_title
        fill_in "question[content]", :with => @question_content
      end
      #点击提交后，问题创建成功并回到问题列表页面
      click_button "提交"
      expect(page).to have_css ".page-questions-index"
    #判断问题是否创建成功
    }.to change{QuestionMod::Question.count}.by(1)
  end
end
