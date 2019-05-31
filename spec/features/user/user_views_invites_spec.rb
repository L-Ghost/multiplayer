require 'rails_helper'

feature 'User views invites' do
  let(:user) { create(:user) }

  scenario 'successfully' do
    ei1 = create(:event_invite, invitee: user)
    ei2 = create(:event_invite, invitee: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Ver convites recebidos'

    expect(page).to have_css('h1', text: 'Meus Convites')
    expect(page).to have_link(ei1.event.title)
    expect(page).to have_link(ei2.event.title)
    expect(page).to have_button('Aceitar', count: 2)
    expect(page).to have_button('Recusar', count: 2)
    expect(page).to have_content('Você tem 2 convites de eventos')
  end

  scenario 'that were not answered' do
    ei1 = create(:event_invite, :approved, invitee: user)
    ei2 = create(:event_invite, invitee: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Ver convites recebidos'

    expect(page).to have_css('h1', text: 'Meus Convites')
    expect(page).not_to have_link(ei1.event.title)
    expect(page).to have_link(ei2.event.title)
    expect(page).to have_button('Aceitar', count: 1)
    expect(page).to have_button('Recusar', count: 1)
    expect(page).to have_content('Você tem 1 convite de eventos')
  end

  scenario 'but there are no invites' do
    event = create(:event)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Ver convites recebidos'

    expect(page).to have_css('h1', text: 'Meus Convites')
    expect(page).not_to have_link(event.title)
    expect(page).not_to have_button('Aceitar')
    expect(page).not_to have_button('Recusar')
    expect(page).to have_content('Você não tem nenhum novo convite')
  end

  scenario 'and view star with invite count' do
    create(:event_invite, invitee: user)

    login_as(user, scope: :user)
    visit root_path

    expect(page).to have_link('Ver convites recebidos')
    expect(page).to have_css('img[src*="received_invites.png"]')
    expect(page).to have_css('img[title*="Você tem 1 convite de evento"]')
  end
end
