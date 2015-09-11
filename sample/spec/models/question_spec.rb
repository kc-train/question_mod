require 'rails_helper'

RSpec.describe QuestionMod::Question, type: :model do
  it "测试问题字段完全通过校验" do
    question = QuestionMod::Question.new(:title => "dg", :content => "dgfg", :vote_sum => 5)
    expect(question).to be_valid
  end
end
