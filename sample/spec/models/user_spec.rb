require 'rails_helper'

RSpec.describe User, type: :model do
  it "测试用户字段完全通过校验" do
    user = User.new(:name => "gff", :email =>  "504371515@qq.com", :password => "123456")
    expect(user).to be_valid
  end
end