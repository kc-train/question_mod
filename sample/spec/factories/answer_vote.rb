FactoryGirl.define do
  factory :answer_vote, :class => QuestionMod::AnswerVote do
    kind :up
    association :creator, factory: :user
    association :answer, factory: :answer
  end
end