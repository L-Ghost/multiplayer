FactoryBot.define do
  factory :event_request do
    event
    user
    request_status { :sent }
  end
end
