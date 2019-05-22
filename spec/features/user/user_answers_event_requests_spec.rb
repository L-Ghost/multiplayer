require 'rails_helper'

feature 'User answers event requests' do
  scenario 'successfully' do
    user1 = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    event = create(:event, user: user1)
    event_request1 = create(:event_request, event: event, user: user2)
    event_request2 = create(:event_request, event: event, user: user3)

    login_as user1, scope: :user
    visit event_path(event)

    expect(page).to have_content(event_request1.user.name)
    expect(page).to have_content(event_request2.user.name)
    expect(page).to have_link('Aceitar', count: 2)
    expect(page).to have_link('Recusar', count: 2)
  end

  scenario 'and accepts request' do
    user1 = create(:user)
    user2 = create(:user)
    event = create(:event, user: user1)
    create(:event_request, event: event, user: user2)

    login_as user1, scope: :user
    visit event_path(event)
    click_on 'Aceitar'

    expect(current_path).to eq event_path(event)
    expect(page).to have_content('Pedido aceito com sucesso!')
    expect(page).to have_content(user2.nickname)
    expect(page).not_to have_link('Aceitar')
  end

  scenario 'and declines request' do
    user1 = create(:user)
    user2 = create(:user)
    event = create(:event, user: user1)
    create(:event_request, event: event, user: user2)

    login_as user1, scope: :user
    visit event_path(event)
    click_on 'Recusar'

    expect(current_path).to eq event_path(event)
    expect(page).to have_content('Pedido recusado!')
    expect(page).not_to have_content(user2.nickname)
    expect(page).not_to have_link('Recusar')
  end
end
