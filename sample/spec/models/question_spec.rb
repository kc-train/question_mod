require 'rails_helper'

RSpec.describe QuestionMod::Question, type: :model do
  describe "创建用户1" do
    before{
      @user1 = FactoryGirl.create(:user)
    }

    it "测试问题字段完全通过校验" do
      question = QuestionMod::Question.create(:title => "hgh", :content => "dgfg",:creator => @user1)
      expect(question).to be_valid
    end

    it "测试创建问题成功" do
      expect{
        question = QuestionMod::Question.create(:title => "dg", :content => "dgfg",:creator => @user1)
      }.to change{QuestionMod::Question.count}.by(1)
    end
  end
end
