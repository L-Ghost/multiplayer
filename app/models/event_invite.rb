class EventInvite < ApplicationRecord
  enum invite_status: %i[sent approved declined]

  belongs_to :event
  belongs_to :user, inverse_of: :sent_invites
  belongs_to :invitee, class_name: 'User', inverse_of: :received_invites

  scope :sent, -> { where(invite_status: :sent) }

  def sent_invite
    SendNewSentInviteJob.perform_later(id)
  end

  def received_invite
    SendNewReceivedInviteJob.perform_later(id)
  end
end
