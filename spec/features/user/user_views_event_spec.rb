require 'rails_helper'

feature 'User views event' do
  let(:has_requested) { 'Você já solicitou participar deste evento' }

  scenario 'where it has sent a request to' do
    user = create(:user)
    event = create(:event)
    create(:event_request, event: event, user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Ver detalhes'

    expect(page).to have_css('h4', text: has_requested)
    expect(page).not_to have_link('Pedir para participar deste evento')
    expect(page).not_to have_css('p', text: 'Todas as vagas estão preenchidas')
  end

  scenario 'where it has not sent a request to' do
    user = create(:user)
    create(:event)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Ver detalhes'

    expect(page).not_to have_css('h4', text: has_requested)
    expect(page).to have_link('Pedir para participar deste evento')
    expect(page).not_to have_css('p', text: 'Todas as vagas estão preenchidas')
  end

  scenario 'where it has not sent a request to, but event is full' do
    user = create(:user)
    event = create(:event, user_limit: 4)
    4.times { create(:event_participation, event: event) }

    login_as(user, scope: :user)
    visit root_path
    click_on 'Ver detalhes'

    expect(page).not_to have_css('h4', text: has_requested)
    expect(page).not_to have_link('Pedir para participar deste evento')
    expect(page).to have_css('p', text: 'Todas as vagas estão preenchidas')
  end
end
