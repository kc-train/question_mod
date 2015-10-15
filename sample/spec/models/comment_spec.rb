# require 'rails_helper'

# RSpec.describe QuestionMod::Comment, type: :model do
#   describe "创建用户1和用户2，用户1创建问题1，用户2对问题1创建回答1" do
#     before{
#       @user1 = FactoryGirl.create(:user)
#       @user2 = FactoryGirl.create(:user)
#       @question1 = FactoryGirl.create(:question, :creator => @user1)
#       @answer1 = FactoryGirl.create(:answer, :creator => @user2, :question => @question1)
#     }

#     describe "用户2对问题1创建评论" do
#       before{
#         @comment1 = FactoryGirl.create(:comment, :creator => @user1, :question => @question1)
#       }

#       it "创建成功" do
#         expect(@question1.comments.count).to eq(1)
#       end
#     end
#   end
# end
