require 'rails_helper'

RSpec.describe KcNotifications::Notification, type: :model do
  describe "创建用户1和用户2，用户1创建问题1，用户2对问题1创建回答1" do
    before{
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @question1 = FactoryGirl.create(:question, :creator => @user1)
      @answer1 = FactoryGirl.create(:answer, :creator => @user2, :question => @question1)
    }
    
    it "回答通知是否被创建" do
      answer_notification = @user1.notifications.with_kind("question").first.info[:str1] + @user1.notifications.with_kind("question").first.info[:question_title] + @user1.notifications.with_kind("question").first.info[:str2]
      expect(answer_notification).to eq("您的问题title3收到一个新的回答")
    end

    describe "用户2对用户1创建的问题1投赞同票" do
      before{
        @question1.vote_up_by(@user2)
      }

      it "投票通知是否被创建" do
        vote_notification = @user1.notifications.with_kind("question").last.info[:str1] + @user1.notifications.with_kind("question").last.info[:question_title] + @user1.notifications.with_kind("question").last.info[:str2]
        expect(vote_notification).to eq("您的问题title6获得了一次赞")
      end
    end

    describe "用户2对用户1创建的问题1投反对票" do
      before{
        @question1.vote_down_by(@user2)
      }

      it "投票通知是否被创建" do
        vote_notification = @user1.notifications.with_kind("question").last.info[:str1] + @user1.notifications.with_kind("question").last.info[:question_title] + @user1.notifications.with_kind("question").last.info[:str2]
        expect(vote_notification).to eq("您的问题title9获得了一次踩")
      end
    end

    describe "用户1对用户2创建的回答1投赞同票" do
      before{
        @answer1.vote_up_by(@user1)
      }

      it "投票通知是否被创建" do
        vote_notification = @user2.notifications.with_kind("question").first.info[:str1] + @user2.notifications.with_kind("question").first.info[:question_title] + @user2.notifications.with_kind("question").first.info[:str2]
        expect(vote_notification).to eq("您在问题title12的回答获得了一次赞")
      end
    end

    describe "用户1对用户2创建的回答1投赞同票" do
      before{
        @answer1.vote_down_by(@user1)
      }

      it "投票通知是否被创建" do
        vote_notification = @user2.notifications.with_kind("question").first.info[:str1] + @user2.notifications.with_kind("question").first.info[:question_title] + @user2.notifications.with_kind("question").first.info[:str2]
        expect(vote_notification).to eq("您在问题title15的回答获得了一次踩")
      end
    end

    describe "用户2对问题1创建评论" do
      before{
        @question1.comments.create(:content => "122", :creator => @user2)
      }

      it "评论通知是否被创建" do
        comment_notification = @user1.notifications.with_kind("question").last.info[:str1] + @user1.notifications.with_kind("question").last.info[:question_title] + @user1.notifications.with_kind("question").last.info[:str2]
        expect(comment_notification).to eq("您的问题title18收到一个新的评论")
      end

      describe "用户1对用户2对问题1的评论进行回复" do
        before{
          comment1 = @question1.comments.create(:content => "122", :creator => @user2)
          @question1.comments.create(:content => "123", :creator => @user1, :reply_comment => comment1)
        }

        it "评论通知是否被创建" do
          comment_notification = @user2.notifications.with_kind("question").last.info[:str1] + @user2.notifications.with_kind("question").last.info[:question_title] + @user2.notifications.with_kind("question").last.info[:str2]
          expect(comment_notification).to eq("您在问题title21下的评论收到一个新的回复")
        end
      end
    end

    describe "用户1对回答1创建评论" do
      before{
        @answer1.comments.create(:content => "122", :creator => @user1)
      }

      it "评论通知是否被创建" do
        comment_notification = @user2.notifications.with_kind("question").first.info[:str1] + @user2.notifications.with_kind("question").first.info[:question_title] + @user2.notifications.with_kind("question").first.info[:str2]
        expect(comment_notification).to eq("您在问题title24下的回答收到一个新的评论")
      end

      describe "用户2对用户1对回答1的评论进行回复" do
        before{
          comment1 = @answer1.comments.create(:content => "122", :creator => @user1)
          @answer1.comments.create(:content => "123", :creator => @user2, :reply_comment => comment1)
        }

        it "评论通知是否被创建" do
          comment_notification = @user1.notifications.with_kind("question").last.info[:str1] + @user1.notifications.with_kind("question").last.info[:question_title] + @user1.notifications.with_kind("question").last.info[:str2]
          expect(comment_notification).to eq("您在问题title27下的评论收到一个新的回复")
        end
      end
    end
  end
end