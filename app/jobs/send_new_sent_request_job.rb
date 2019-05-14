class SendNewSentRequestJob < ApplicationJob
  queue_as :default

  def perform(event_request_id)
    event_request = EventRequest.find(event_request_id)

    EventRequestMailer.sent_request(event_request_id).deliver_now
  end
end
