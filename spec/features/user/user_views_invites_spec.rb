require 'rails_helper'

feature 'User views invites' do
  scenario 'successfully' do
    user = create(:user)
    event1 = create(:event)
    event2 = create(:event)
    create(:event_invite, invitee: user, event: event1)
    create(:event_invite, invitee: user, event: event2)

    login_as user, scope: :user
    visit root_path
    click_on 'Ver convites recebidos'

    expect(page).to have_css('h1', text: 'Meus Convites')
    expect(page).to have_link(event1.title)
    expect(page).to have_link(event2.title)
    expect(page).to have_link('Aceitar', count: 2)
    expect(page).to have_link('Recusar', count: 2)
    expect(page).to have_content('Você tem 2 convites de eventos')
  end

  scenario 'that were not responded' do
    user = create(:user)
    event1 = create(:event)
    event2 = create(:event)
    create(:event_invite, :approved, invitee: user, event: event1)
    create(:event_invite, invitee: user, event: event2)

    login_as user, scope: :user
    visit root_path
    click_on 'Ver convites recebidos'

    expect(page).to have_css('h1', text: 'Meus Convites')
    expect(page).not_to have_link(event1.title)
    expect(page).to have_link(event2.title)
    expect(page).to have_link('Aceitar', count: 1)
    expect(page).to have_link('Recusar', count: 1)
    expect(page).to have_content('Você tem 1 convites de eventos')
  end

  scenario 'but there are no invites' do
    user = create(:user)
    event = create(:event)

    login_as user, scope: :user
    visit root_path
    click_on 'Ver convites recebidos'

    expect(page).to have_css('h1', text: 'Meus Convites')
    expect(page).not_to have_link(event.title)
    expect(page).not_to have_link('Aceitar')
    expect(page).not_to have_link('Recusar')
    expect(page).to have_content('Você não tem nenhum novo convite')
  end

  scenario 'and view star with invite count' do
    user = create(:user)
    event = create(:event)
    create(:event_invite, invitee: user, event: event)

    login_as user, scope: :user
    visit root_path

    expect(page).to have_link('Ver convites recebidos')
    expect(page).to have_css('img[src*="received_invites.png"]')
    expect(page).to have_css('img[title*="Você tem 1 convites de eventos"]')
  end

  scenario 'and accepts invite' do
    user = create(:user)
    event_owner = create(:user)
    event = create(:event)
    create(:event_participation, event: event, user: event_owner)
    create(:event_invite, invitee: user, event: event)

    login_as user, scope: :user
    visit received_invites_user_path(user)
    click_link 'Aceitar'

    expect(page).not_to have_link('Aceitar')
    expect(page).not_to have_link('Recusar')
    expect(page).to have_content('Convite aceito com sucesso!')
    expect(EventParticipation.count).to eq(2)
  end

  scenario 'and refuses invite' do
    user = create(:user)
    event_owner = create(:user)
    event = create(:event)
    create(:event_participation, event: event, user: event_owner)
    create(:event_invite, invitee: user, event: event)

    login_as user, scope: :user
    visit received_invites_user_path(user)
    click_link 'Recusar'

    expect(page).not_to have_link('Aceitar')
    expect(page).not_to have_link('Recusar')
    expect(page).to have_content('Convite recusado com sucesso!')
    expect(EventParticipation.count).to eq(1)
  end
end
