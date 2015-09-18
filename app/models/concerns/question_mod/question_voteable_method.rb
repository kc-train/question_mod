module QuestionMod
  module QuestionVoteableMethod
    extend ActiveSupport::Concern

    # kind 可以是如下三个常量之一
    # QuestionVote::KIND_UP
    # QuestionVote::KIND_DOWN
    # nil
    def vote_by(user, kind)
      kind_not_up_and_down = (kind != QuestionVote::KIND_UP && kind != QuestionVote::KIND_DOWN)

      if kind.blank? || kind_not_up_and_down
        question_votes.where(:creator => user).destroy_all
        return
      end

      current_kind = vote_state_of(user)
      if current_kind.blank?
        question_votes.create(:kind => kind, :creator => user)
      else
        vote = question_votes.where(:creator => user).first
        vote.update_attribute(:kind, kind)
      end
    end

    # 返回值是如下三个常量之一
    # QuestionVote::KIND_UP
    # QuestionVote::KIND_DOWN
    # nil
    def vote_state_of(user)
      if question_votes.where(:creator => user).all.first == nil
        return nil
      else
        return question_votes.where(:creator => user).all.first.kind
      end
    end
  end
end
