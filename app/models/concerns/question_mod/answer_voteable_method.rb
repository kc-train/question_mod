module QuestionMod
  module AnswerVoteableMethod
    extend ActiveSupport::Concern

   # 有三种起始状态
    # 1 用户没有任何对应 vote
    # 2 用户已经是 vote_up
    # 3 用户是 vote_down
    def vote_up_by(user)
      _vote_by(user, AnswerVote::KIND_UP, AnswerVote::KIND_DOWN)
    end

    # 有三种起始状态
    # 1 用户没有任何对应 vote
    # 2 用户已经是 vote_up
    # 3 用户是 vote_down
    def vote_down_by(user)
      _vote_by(user, AnswerVote::KIND_DOWN, AnswerVote::KIND_UP)
    end

    def _vote_by(user, kind1, kind2)
      current_kind = vote_state_of(user)

      case current_kind
      when nil
        answer_votes.create(:kind => kind1, :creator => user)
      when kind1
        answer_votes.where(:creator => user).destroy_all
      when kind2
        vote = answer_votes.where(:creator => user).first
        vote.update_attribute(:kind, kind1)
      end
    end

    # 返回值是如下三个常量之一
    # AnswerVote::KIND_UP
    # AnswerVote::KIND_DOWN
    # nil
    def vote_state_of(user)
      if answer_votes.where(:creator => user).all.first == nil
        return nil
      else
        return answer_votes.where(:creator => user).all.first.kind
      end
    end

    def is_vote_up_of(user)
      vote_state_of(user) == AnswerVote::KIND_UP
    end

    def is_vote_down_of(user)
      vote_state_of(user) == AnswerVote::KIND_DOWN
    end
  end
end