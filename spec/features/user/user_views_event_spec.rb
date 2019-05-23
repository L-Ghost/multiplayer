require 'rails_helper'

feature 'User views event' do
  let(:user) { create(:user) }
  let(:has_requested) { 'Você já solicitou participar deste evento' }

  scenario 'where it has sent a request to' do
    event = create(:event)
    create(:event_request, event: event, user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Ver Detalhes'

    expect(page).to have_css('h4', text: has_requested)
    expect(page).not_to have_link('Pedir para participar deste evento')
    expect(page).not_to have_css('p', text: 'Todas as vagas estão preenchidas')
  end

  scenario 'where it has not sent a request to' do
    create(:event)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Ver Detalhes'

    expect(page).not_to have_css('h4', text: has_requested)
    expect(page).to have_link('Pedir para participar deste evento')
    expect(page).not_to have_css('p', text: 'Todas as vagas estão preenchidas')
  end

  scenario 'where it has not sent a request to, but event is full' do
    event = create(:event, user_limit: 4)
    4.times { create(:event_participation, event: event) }

    login_as(user, scope: :user)
    visit root_path
    click_on 'Ver Detalhes'

    expect(page).not_to have_css('h4', text: has_requested)
    expect(page).not_to have_link('Pedir para participar deste evento')
    expect(page).to have_css('p', text: 'Todas as vagas estão preenchidas')
  end

  scenario 'where it is taking part on event' do
    event = create(:event)
    create(:event_participation, event: event, user: user)
    ep2 = create(:event_participation, event: event)
    ep3 = create(:event_participation, event: event)

    login_as(user, scope: :user)
    visit event_path(event)

    expect(page).to have_css('strong', text: '(Você)', count: 1)
    expect(page).to have_content(user.nickname)
    expect(page).to have_content(ep2.user.nickname)
    expect(page).to have_content(ep3.user.nickname)
  end

  scenario 'where it is not taking part on event' do
    event = create(:event)
    ep1 = create(:event_participation, event: event)
    ep2 = create(:event_participation, event: event)

    login_as(user, scope: :user)
    visit event_path(event)

    expect(page).not_to have_css('strong', text: '(Você)')
    expect(page).not_to have_content(user.nickname)
    expect(page).to have_content(ep1.user.nickname)
    expect(page).to have_content(ep2.user.nickname)
  end
end
