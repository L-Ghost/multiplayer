module EventInviteService
  class << self
    def find_user(params)
      if params[:user_id].nil?
        return User.find_by!('nickname = :q OR email = :q', q: params[:q])
      end

      User.find(params[:user_id])
    end

    def invite_user_procedure(event, user, invited_user)
      if invite_exists?(event, user, invited_user)
        return I18n.t('event.invite.already_sent')
      end

      event_invite = create_event_invite(event, user, invited_user)
      send_emails(event_invite)
      invited_user_message(invited_user)
    end

    private

    def invite_exists?(event, user, invited_user)
      !EventInvite.find_by(
        event: event, user: user, invitee: invited_user
      ).nil?
    end

    def create_event_invite(event, user, invited_user)
      event_invite = EventInvite.create(
        event: event,
        user: user,
        invitee: invited_user
      )
      event_invite.sent!
      event_invite
    end

    def send_emails(event_invite)
      event_invite.sent_invite
      event_invite.received_invite
    end

    def invited_user_message(invited_user)
      I18n.t('event.invite.sent.nickname', nickname: invited_user.nickname)
    end
  end
end
