class CreateEventInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :event_invites do |t|
      t.references :event, foreign_key: true
      t.references :user, foreign_key: true
      t.references :invitee

      t.timestamps
    end
  end
end
