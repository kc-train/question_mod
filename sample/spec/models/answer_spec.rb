require 'rails_helper'

RSpec.describe QuestionMod::Answer, type: :model do
  it "回答字段完全通过校验" do
    answer = QuestionMod::Answer.new(:content => "dgfg", :vote_sum => 5)
    expect(answer).to be_valid
  end
end
