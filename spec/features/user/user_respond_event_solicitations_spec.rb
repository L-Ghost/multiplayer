require 'rails_helper'

feature 'User view event solicitations' do
  scenario 'successfully' do
    user1 = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    event = create(:event, user: user1)
    event_request1 = create(:event_request, user: user2, event_owner: user1)
    event_request2 = create(:event_request, user: user3, event_owner: user1)

    login_as user1, scope: :user
    visit event_path(event)

    expect(page).to have_content(event_request1.user.name)
    expect(page).to have_content(event_request2.user.name)
    expect(page).to have_link('Aceitar', count: 2)
    expect(page).to have_link('Recusar', count: 2)
  end
end