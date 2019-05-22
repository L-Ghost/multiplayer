class RemoveEventOwnerAgainFromEventRequest < ActiveRecord::Migration[5.2]
  def change
    remove_reference :event_requests, :event_owner
  end
end
