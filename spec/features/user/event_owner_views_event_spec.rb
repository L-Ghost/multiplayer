require 'rails_helper'

feature 'Event owner views event' do
  let(:user) { create(:user) }
  let(:event) { create(:event, user: user) }

  scenario 'and sees requests' do
    er1 = create(:event_request, event: event)
    er2 = create(:event_request, event: event)

    login_as(user, scope: :user)
    visit event_path(event)

    expect(page).to have_content(er1.user.name)
    expect(page).to have_content(er2.user.name)
    expect(page).to have_button('Aceitar', count: 2)
    expect(page).to have_button('Recusar', count: 2)
  end

  scenario 'and sees event participants' do
    ep1 = create(:event_participation, event: event, user: user)
    ep2 = create(:event_participation, event: event)
    ep3 = create(:event_participation, event: event)

    login_as(user, scope: :user)
    visit event_path(event)

    expect(page).to have_css('h2', text: 'Participantes do Evento')
    expect(page).to have_content(ep1.user.nickname)
    expect(page).to have_css('strong', text: '(Você)', count: 1)
    expect(page).to have_content(ep2.user.nickname)
    expect(page).to have_content(ep3.user.nickname)
  end

  scenario 'and there are no participation requests' do
    login_as(user, scope: :user)
    visit event_path(event)

    expect(page).to have_css('h2', text: 'Pedidos de Participação')
    expect(page).to have_content('Não há pedidos para participar deste evento')
  end
end
