class CreateEventRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :event_requests do |t|
      t.references :event, foreign_key: true
      t.references :user, foreign_key: true
      t.references :event_owner
      t.integer :request_status

      t.timestamps
    end
  end
end
