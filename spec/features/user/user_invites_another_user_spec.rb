require 'rails_helper'

feature 'User invites another user' do
  let(:q) { 'Informe o Email ou Nickname do usuário' }
  let(:invited_before) { 'Este usuário já foi convidado anteriormente' }
  let(:not_found) { 'Não foi encontrado um usuário com este email' }
  let(:user) { create(:user) }

  context 'successfully' do
    let(:another_user) { create(:user) }
    let(:event) { create(:event, user: user) }

    scenario 'through email' do
      login_as(user, scope: :user)
      visit event_path(event)
      fill_in q, with: another_user.email
      click_on 'Convidar'

      expect(page).to have_content(convite_enviado(another_user))
      expect(page).to have_content('Convidar Usuários para Evento')
      expect(EventInvite.count).to eq(1)
    end

    scenario 'through nickname' do
      login_as(user, scope: :user)
      visit event_path(event)
      fill_in q, with: another_user.nickname
      click_on 'Convidar'

      expect(page).to have_content(convite_enviado(another_user))
      expect(page).to have_content('Convidar Usuários para Evento')
      expect(EventInvite.count).to eq(1)
    end

    scenario 'through user page' do
      event = create(:event, user: user)

      login_as(user, scope: :user)
      visit user_path(another_user)
      select event.title, from: 'Convidar para Evento'
      click_on 'Convidar'

      expect(page).to have_content(convite_enviado(another_user))
      expect(page).not_to have_content('Convidar Usuários para Evento')
      expect(EventInvite.count).to eq(1)
    end
  end

  context 'unsuccessfully' do
    let(:event) { create(:event, user: user) }

    scenario 'informing an inexistent email' do
      login_as(user, scope: :user)
      visit event_path(event)
      fill_in q, with: 'emailquenao@existe.com'
      click_on 'Convidar'

      expect(page).to have_content(not_found)
      expect(page).to have_content('Convidar Usuários para Evento')
      expect(EventInvite.count).to eq(0)
    end

    scenario 'without having the permission' do
      event = create(:event)

      login_as(user, scope: :user)
      visit event_path(event)

      expect(page).not_to have_content(q)
      expect(page).not_to have_content('Convidar Usuários para Evento')
    end

    scenario 'twice' do
      another_user = create(:user)
      create(:event_invite, event: event, user: user, invitee: another_user)

      login_as(user, scope: :user)
      visit event_path(event)
      fill_in q, with: another_user.email
      click_on 'Convidar'

      expect(EventInvite.count).to eq(1)
      expect(page).to have_content(invited_before)
      expect(page).not_to have_content(convite_enviado(another_user))
    end
  end

  def convite_enviado(user)
    "Convite enviado para o usuário #{user.nickname}"
  end
end
