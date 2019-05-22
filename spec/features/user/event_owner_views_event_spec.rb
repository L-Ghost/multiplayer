require 'rails_helper'

feature 'Event owner views event' do
  scenario 'and sees event participants' do
    user = create(:user)
    event = create(:event, user: user)
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
    user = create(:user)
    event = create(:event, user: user)

    login_as(user, scope: :user)
    visit event_path(event)

    expect(page).to have_css('h2', text: 'Pedidos de Participação')
    expect(page).to have_content('Não há pedidos para participar deste evento')
  end
end
