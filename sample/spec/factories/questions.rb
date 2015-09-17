FactoryGirl.define do
  factory :question, :class => QuestionMod::Question do
    sequence :title do |n|
      "title#{n}"
    end
    sequence :content do |n|
      "content#{n}"
    end
    association :creator, factory: :user
  end
end
