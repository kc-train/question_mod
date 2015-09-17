require 'rails_helper'

RSpec.feature "Users", type: :feature do
  # it "测试用户注册成功" do
  #   expect{
  #     @user_name1 = "用户1"
  #     @email1     = "147258369@qq.com"
  #     @password1  = "zjb5363883"
  #     visit "/"
  #     #点击注册
  #     first("a.create-user").click
  #     #进入注册页面，填入相关信息点击提交
  #     within(".page-container") do
  #       fill_in "用户名",   :with => @user_name1
  #       fill_in "Email",    :with => @email1
  #       fill_in "密码",     :with => @password1
  #       fill_in "密码验证", :with => @password1
  #     end
  #     click_button '提交'
  #     #回到首页
  #     expect(page).to have_css ".engine-generated"
  #   #判断用户是否注册成功
  #   }.to change{User.count}.by(1)
  # end

  # it "测试用户登录成功" do
  #   @user_name1 = "用户1"
  #   @email1     = "147258369@qq.com"
  #   @password1  = "zjb5363883"
  #   @user_name2 = "用户2"
  #   @email2     = "1472583690@qq.com"
  #   @password2  = "zjb1598742360"
  #   visit "/"
  #   #点击注册
  #   first("a.create-user").click
  #   #进入注册页面，填入相关信息点击提交
  #   within(".page-container") do
  #     fill_in "用户名",   :with => @user_name1
  #     fill_in "Email",    :with => @email1
  #     fill_in "密码",     :with => @password1
  #     fill_in "密码验证", :with => @password1
  #   end
  #   click_button '提交'
  #   #注册成功回到首页，点击登录
  #   first("a.log-in").click
  #   #进入登录页面，填入正确的邮箱和密码，点击提交
  #   within(".page-container") do
  #     fill_in "Email",    :with => @email1
  #     fill_in "密码",     :with => @password1
  #   end
  #   click_button '提交'
  #   #回到首页，并显示当前用户
  #   expect(page).to have_css ".desc.current-user"
  # end

  # it "测试用户登出成功" do
  #   @user_name1 = "用户1"
  #   @email1     = "147258369@qq.com"
  #   @password1  = "zjb5363883"
  #   @user_name2 = "用户2"
  #   @email2     = "1472583690@qq.com"
  #   @password2  = "zjb1598742360"
  #   visit "/"
  #   #点击注册
  #   first("a.create-user").click
  #   #进入注册页面，填入相关信息点击提交
  #   within(".page-container") do
  #     fill_in "用户名",   :with => @user_name1
  #     fill_in "Email",    :with => @email1
  #     fill_in "密码",     :with => @password1
  #     fill_in "密码验证", :with => @password1
  #   end
  #   click_button '提交'
  #   #注册成功回到首页，点击登录
  #   first("a.log-in").click
  #   #进入登录页面，填入正确的邮箱和密码，点击提交
  #   within(".page-container") do
  #     fill_in "Email",    :with => @email1
  #     fill_in "密码",     :with => @password1
  #   end
  #   click_button '提交'
  #   #回到首页，并显示当前用户
  #   expect(page).to have_css ".desc.current-user"
  #   #点击登出
  #   first("a.log-out").click
  #   #回到首页，当前用户为空
  #   expect(page).to have_css ".engine-generated"
  #   expect(page).not_to have_css ".desc.current-user"
  # end
end
