class EventRequest < ApplicationRecord
  enum request_status: %i[sent approved declined]

  belongs_to :event
  belongs_to :user
  has_one :event_owner, through: :event, source: :user

  def sent_request
    SendNewSentRequestJob.perform_later(id)
  end

  def received_request
    SendNewReceivedRequestJob.perform_later(id)
  end
end
