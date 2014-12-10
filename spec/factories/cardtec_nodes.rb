FactoryGirl.define do
  factory :node, class: Cardtec::Node do
    sequence :neo_id do |n|
      n
    end
    sequence :uuid do |n|
      SecureRandom.uuid
    end
    title "title"
    body "body"
  end
end