require 'rails_helper'

feature 'User answers event requests' do
  let(:user) { create(:user) }
  let(:event) { create(:event, user: user) }

  scenario 'successfully' do
    er1 = create(:event_request, event: event)
    er2 = create(:event_request, event: event)

    login_as user, scope: :user
    visit event_path(event)

    expect(page).to have_content(er1.user.name)
    expect(page).to have_content(er2.user.name)
    expect(page).to have_button('Aceitar', count: 2)
    expect(page).to have_button('Recusar', count: 2)
  end

  scenario 'and accepts request' do
    er = create(:event_request, event: event)

    login_as user, scope: :user
    visit event_path(event)
    click_on 'Aceitar'

    expect(current_path).to eq event_path(event)
    expect(page).to have_content('Pedido aceito com sucesso!')
    expect(page).to have_content(er.user.nickname)
    expect(page).not_to have_link('Aceitar')
  end

  scenario 'and declines request' do
    er = create(:event_request, event: event)

    login_as user, scope: :user
    visit event_path(event)
    click_on 'Recusar'

    expect(current_path).to eq event_path(event)
    expect(page).to have_content('Pedido recusado!')
    expect(page).not_to have_content(er.user.nickname)
    expect(page).not_to have_link('Recusar')
  end
end
