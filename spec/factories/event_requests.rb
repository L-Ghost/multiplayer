FactoryBot.define do
  factory :event_request do
    event
    user
    request_status { :sent }
    association :event_owner, factory: :user
  end
end
