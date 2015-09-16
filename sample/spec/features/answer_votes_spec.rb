require 'rails_helper'

RSpec.feature "AnswerVotes", type: :feature do
  it "测试用户1对用户2对问题1的回答进行投票和对投票的修改和取消" do
    @user_name1 = "用户1"
    @email1     = "147258369@qq.com"
    @password1  = "zjb5363883"
    @user_name2 = "用户2"
    @email2     = "1472583690@qq.com"
    @password2  = "zjb1598742360"
    @question_title   = "加法"
    @question_content = "1 + 1 = ?"
    @answer_content1  = "2"
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
    #用户2登录并回答
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
    #回到首页
    visit "/"
    #用户2登出
    first("a.log-out").click
    #用户1登录
    first("a.log-in").click
    #进入登录页面，填入正确的邮箱和密码，点击提交
    within(".page-container") do
      fill_in "Email",    :with => @email1
      fill_in "密码",     :with => @password1
    end
    click_button '提交'
    #点击提问进入问题列表页面
    first("a.to-questions").click
    expect{
      #点击赞同按钮，投赞同票
      click_link "赞同"
      #进入投票页面，选择up，点击确定
      within(".page-new-answer-votes") do
        choose("Up")
      end
      click_button "确定"
    #判断是否投票成功
    }.to change{QuestionMod::AnswerVote.count}.by(1)
    #判断是否为赞同票
    answer = QuestionMod::Answer.all.first
    expect(answer.vote_sum).to eq(1)
    #回问题列表页面，点击修改投票
    click_link "修改投票"
    #进入修改投票页面，选择down，点击确定
    within(".page-edit-answer-votes") do
      choose("Down")
    end
    click_button "确定"
    #判断赞同票是否变为反对票
    answer = QuestionMod::Answer.all.first
    expect(answer.vote_sum).to eq(-1)
    #回问题列表页面，点击取消投票
    expect{
      click_link "取消投票"
    #判断投票是否被取消
    }.to change{QuestionMod::AnswerVote.count}.by(-1)
    answer = QuestionMod::Answer.all.first
    expect(answer.vote_sum).to eq(0)
    expect{
      #点击反对按钮，投反对票
      click_link "反对"
      #进入投票页面，选择down，点击确定
      within(".page-new-answer-votes") do
        choose("Down")
      end
      click_button "确定"
    #判断是否投票成功
    }.to change{QuestionMod::AnswerVote.count}.by(1)
    #判断是否为反对票
    answer = QuestionMod::Answer.all.first
    expect(answer.vote_sum).to eq(-1)
  end
end
