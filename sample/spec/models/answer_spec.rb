require 'rails_helper'

RSpec.describe QuestionMod::Answer, type: :model do
  before{
    # @user1 = FactoryGirl.create(:user)
    # @user2 = FactoryGirl.create(:user)
    # @question1 = FactoryGirl.create(:question, :creator => @user1)
    # p @question1
  }
  it "回答字段完全通过校验" do
    answer = QuestionMod::Answer.new(:content => "dgfg", :creator => @user2)
    expect(answer).to be_valid
  end
end
