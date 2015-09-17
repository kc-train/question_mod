FactoryGirl.define do
  factory :question_vote, :class => QuestionMod::QuestionVote do
    kind :up
    association :creator, factory: :user
    association :question, factory: :question
  end
end