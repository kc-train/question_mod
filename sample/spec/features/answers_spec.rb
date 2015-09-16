require 'rails_helper'

RSpec.feature "Answers", type: :feature do
  it "测试用户2对用户1创建的问题1进行回答和对回答的修改成功" do
    @user_name1 = "用户1"
    @email1     = "147258369@qq.com"
    @password1  = "zjb5363883"
    @user_name2 = "用户2"
    @email2     = "1472583690@qq.com"
    @password2  = "zjb1598742360"
    @question_title   = "加法"
    @question_content = "1 + 1 = ?"
    @answer_content1  = "2"
    @answer_content2  = "二"
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
    expect(page).to have_css ".page-questions-index"
    #点击提问进入创建问题表单页面，并填入相关信息
    click_link "提问"
    within(".page-new-questions") do
      fill_in "question[title]",   :with => @question_title
      fill_in "question[content]", :with => @question_content
    end
    #点击提交后，问题创建成功并回到问题列表页面
    click_button "提交"
    expect{
      #回到首页
      visit "/"
      #点击登出确保用户已登出
      first("a.log-out").click
      #点击注册
      first("a.create-user").click
      #进入注册页面，填入相关信息点击提交
      within(".page-container") do
        fill_in "用户名",   :with => @user_name2
        fill_in "Email",    :with => @email2
        fill_in "密码",     :with => @password2
        fill_in "密码验证", :with => @password2
      end
      click_button '提交'
      #注册成功回到首页，点击提问进入问题列表页面
      first("a.to-questions").click
      #点击回答进入创建回答表单页面，并填入相关信息
      click_link "回答"
      within(".page-new-answers") do
        fill_in "answer[content]",   :with => @answer_content1
      end
      #点击提交后，问题创建成功并回到问题列表页面
      click_button "提交"
    #判断回答是否创建成功
    }.to change{QuestionMod::Answer.count}.by(1)
    #点击修改进入修改回答表单页面，并填入相关信息
    click_link "修改"
    within(".page-edit-answers") do
      fill_in "answer[content]",   :with => @answer_content2
    end
    #点击提交后，问题修改成功并回到问题列表页面
    click_button "提交"
    #判断回答是否修改成功
    answer = QuestionMod::Answer.all.first
    expect(answer.content).to eq(@answer_content2)
  end
end

