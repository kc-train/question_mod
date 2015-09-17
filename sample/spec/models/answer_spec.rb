require 'rails_helper'

RSpec.describe QuestionMod::Answer, type: :model do
  before{
    @user1 = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
    @question1 = FactoryGirl.create(:question, :creator => @user1)
    @answer1 = FactoryGirl.create(:answer, :creator => @user2, :question => @question1)
  }

  it "回答字段完全通过校验" do
    answer = QuestionMod::Answer.new(:content => "dgfg", :creator => @user2, :question => @question1)
    expect(answer).to be_valid
  end

  it "测试用户2对用户1创建的问题1进行回答成功" do
    expect{
      answer = FactoryGirl.create(:answer, :creator => @user2, :question => @question1)  
    }.to change{QuestionMod::Answer.count}.by(1)
  end

  it "测试用户2对回答1进行修改成功" do
    @answer1.update(:content => "sb") 
    expect(@answer1.content).to eq("sb")
  end
end
