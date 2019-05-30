require 'rails_helper'

feature 'User answers event invites' do
  let(:user) { create(:user) }
  let(:event) { create(:event) }

  context 'from invites page' do
    scenario 'and accepts invite' do
      create(:event_invite, invitee: user, event: event)
      ep = create(:event_participation, event: event)

      login_as user, scope: :user
      visit received_invites_event_invites_path
      click_button 'Aceitar'

      expect(page).not_to have_link('Aceitar')
      expect(page).not_to have_link('Recusar')
      expect(page).to have_content('Convite aceito com sucesso!')
      expect(EventParticipation.count).to eq(2)
      expect(page).not_to have_content(ep.user.nickname)
    end

    scenario 'and refuses invite' do
      create(:event_invite, invitee: user, event: event)
      ep = create(:event_participation, event: event)

      login_as user, scope: :user
      visit received_invites_event_invites_path
      click_button 'Recusar'

      expect(page).not_to have_link('Aceitar')
      expect(page).not_to have_link('Recusar')
      expect(page).to have_content('Convite recusado!')
      expect(EventParticipation.count).to eq(1)
      expect(page).not_to have_content(ep.user.nickname)
    end
  end

  context 'from event page' do
    scenario 'and accepts invite' do
      create(:event_invite, invitee: user, event: event)
      ep = create(:event_participation, event: event)

      login_as user, scope: :user
      visit event_path(event)
      click_button 'Aceitar'

      expect(page).not_to have_button('Aceitar')
      expect(page).not_to have_button('Recusar')
      expect(page).to have_content('Convite aceito com sucesso!')
      expect(EventParticipation.count).to eq(2)
      expect(page).to have_content(ep.user.nickname)
      expect(page).to have_content(user.nickname)
    end

    scenario 'and refuses invite' do
      create(:event_invite, invitee: user, event: event)
      ep = create(:event_participation, event: event)

      login_as user, scope: :user
      visit event_path(event)
      click_button 'Recusar'

      expect(page).not_to have_button('Aceitar')
      expect(page).not_to have_button('Recusar')
      expect(page).to have_content('Convite recusado!')
      expect(EventParticipation.count).to eq(1)
      expect(page).to have_content(ep.user.nickname)
      expect(page).not_to have_content(user.nickname)
    end
  end
end
