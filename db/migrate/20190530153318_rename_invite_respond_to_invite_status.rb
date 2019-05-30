class RenameInviteRespondToInviteStatus < ActiveRecord::Migration[5.2]
  def change
    rename_column :event_invites, :invite_respond, :invite_status
  end
end
