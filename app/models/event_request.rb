class EventRequest < ApplicationRecord
  enum request_status: %i[sent approved declined]

  belongs_to :event
  belongs_to :user
  belongs_to :event_owner, class_name: 'User'
end
