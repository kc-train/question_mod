module QuestionMod
  module VoteableMethod
    extend ActiveSupport::Concern

   # 有三种起始状态
    # 1 用户没有任何对应 vote
    # 2 用户已经是 vote_up
    # 3 用户是 vote_down
    def vote_up_by(user)
      _vote_by(user, Vote::KIND_UP, Vote::KIND_DOWN)
    end

    # 有三种起始状态
    # 1 用户没有任何对应 vote
    # 2 用户已经是 vote_up
    # 3 用户是 vote_down
    def vote_down_by(user)
      _vote_by(user, Vote::KIND_DOWN, Vote::KIND_UP)
    end

    def _vote_by(user, kind1, kind2)
      current_kind = vote_state_of(user)

      case current_kind
      when nil
        votes.create(:kind => kind1, :creator => user)
      when kind1
        votes.where(:creator => user).destroy_all
      when kind2
        vote = votes.where(:creator => user).first
        vote.update_attribute(:kind, kind1)
      end
    end

    # 返回值是如下三个常量之一
    # AnswerVote::KIND_UP
    # AnswerVote::KIND_DOWN
    # nil
    def vote_state_of(user)
      if votes.where(:creator => user).all.first == nil
        return nil
      else
        return votes.where(:creator => user).all.first.kind
      end
    end

    def is_vote_up_of(user)
      vote_state_of(user) == Vote::KIND_UP
    end

    def is_vote_down_of(user)
      vote_state_of(user) == Vote::KIND_DOWN
    end
  end
end