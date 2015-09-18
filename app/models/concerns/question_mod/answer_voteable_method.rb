module QuestionMod
  module AnswerVoteableMethod
    extend ActiveSupport::Concern

    # kind 可以是如下三个常量之一
    # QuestionVote::KIND_UP
    # QuestionVote::KIND_DOWN
    # nil
    def vote_by(user, kind)
      kind_not_up_and_down = (kind != AnswerVote::KIND_UP && kind != AnswerVote::KIND_DOWN)
      if kind.blank? || kind_not_up_and_down
        answer_votes.where(:creator => user).destroy_all
        return
      end

      current_kind = vote_state_of(user)
      if current_kind.blank?
        answer_votes.create(:kind => kind, :creator => user)
      else
        vote = answer_votes.where(:creator => user).first
        vote.update_attribute(:kind, kind)
      end
    end

    # 返回值是如下三个常量之一
    # QuestionVote::KIND_UP
    # QuestionVote::KIND_DOWN
    # nil
    def vote_state_of(user)
      if answer_votes.where(:creator => user).all.first == nil
        return nil
      else
        return answer_votes.where(:creator => user).all.first.kind
      end
    end
  end
end