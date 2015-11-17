FactoryGirl.define do
  factory :answer, :class => QuestionMod::Answer do
    sequence :content do |n|
      "content#{n}"
    end
    association :creator, factory: :user
    association :question, factory: :question
  end
end