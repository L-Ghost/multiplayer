require 'rails_helper'

feature 'User invites another user' do
  q = 'Informe o Email ou Nickname do usuário'

  scenario 'to an event using email' do
    user = create(:user)
    another_user = create(:user)
    event = create(:event, user: user)

    login_as(user, scope: :user)
    visit event_path(event)
    fill_in q, with: another_user.email
    click_on 'Convidar'

    expect(page).to have_content(convite_enviado(another_user))
    expect(page).to have_content('Convidar Usuários para Evento')
    expect(EventInvite.count).to eq(1)
  end

  scenario 'to an event using nickname' do
    user = create(:user)
    another_user = create(:user)
    event = create(:event, user: user)

    login_as(user, scope: :user)
    visit event_path(event)
    fill_in q, with: another_user.nickname
    click_on 'Convidar'

    expect(page).to have_content(convite_enviado(another_user))
    expect(page).to have_content('Convidar Usuários para Evento')
    expect(EventInvite.count).to eq(1)
  end

  scenario 'but informs an email that does not exist' do
    user = create(:user)
    event = create(:event, user: user)

    login_as(user, scope: :user)
    visit event_path(event)
    fill_in q, with: 'emailquenao@existe.com'
    click_on 'Convidar'

    expect(page).to have_content('Não foi encontrado um usuário com este email')
    expect(page).to have_content('Convidar Usuários para Evento')
    expect(EventInvite.count).to eq(0)
  end

  scenario 'through another user page' do
    user = create(:user)
    another_user = create(:user)
    event = create(:event, user: user)

    login_as(user, scope: :user)
    visit user_path(another_user)
    select event.title, from: 'Convidar para Evento'
    click_on 'Convidar'

    expect(page).to have_content(convite_enviado(another_user))
    expect(page).not_to have_content('Convidar Usuários para Evento')
    expect(EventInvite.count).to eq(1)
  end

  scenario 'only if user is creator of event' do
    user = create(:user)
    event = create(:event)

    login_as(user, scope: :user)
    visit event_path(event)

    expect(page).not_to have_content(q)
    expect(page).not_to have_content('Convidar Usuários para Evento')
  end

  scenario 'when the other user has already been invited' do
    user = create(:user)
    another_user = create(:user)
    event = create(:event, user: user)
    create(:event_invite, event: event, user: user, invitee: another_user)

    login_as(user, scope: :user)
    visit event_path(event)
    fill_in q, with: another_user.email
    click_on 'Convidar'

    expect(EventInvite.count).to eq(1)
    expect(page).to have_content('Este usuário já foi convidado anteriormente')
    expect(page).not_to have_content(convite_enviado(another_user))
  end

  def convite_enviado(user)
    "Convite enviado para o usuário #{user.nickname}"
  end
end
