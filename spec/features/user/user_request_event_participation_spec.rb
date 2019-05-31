require 'rails_helper'

feature 'User request event participation' do
  let(:user) { create(:user) }
  let(:event) { create(:event) }

  scenario 'from event page' do
    login_as user, scope: :user
    visit event_path(event)
    click_on 'Pedir para participar deste evento'

    expect(page).not_to have_link('Pedir para participar deste evento')
    expect(page).to have_content('Pedido de participação enviado com sucesso!')
  end

  scenario 'and event is full' do
    create_list(:event_participation, event.user_limit, event: event)

    login_as user, scope: :user
    visit event_path(event)

    expect(page).not_to have_link('Pedir para participar deste evento')
  end
end
