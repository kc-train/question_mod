# FactoryGirl.define do
#   factory :comment, :class => QuestionMod::Comment do
#     sequence :content do |n|
#       "content#{n}"
#     end
#     association :creator, factory: :user
#     association :targetable, :polymorphic => true
#     association :question, factory: :question
#     association :answer, factory: :answer
#     association :reply_comment, factory: :comment
#   end
# end