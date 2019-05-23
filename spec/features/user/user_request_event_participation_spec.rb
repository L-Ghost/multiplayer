require 'rails_helper'

feature 'User request event participation' do
  scenario 'from event page' do
    user = create(:user)
    create(:event)

    login_as user, scope: :user
    visit root_path
    click_on 'Ver Detalhes'
    click_on 'Pedir para participar deste evento'

    expect(page).not_to have_link('Pedir para participar deste evento')
    expect(page).to have_content('Pedido de participação enviado com sucesso!')
  end

  scenario 'and event is full' do
    user = create(:user)
    create(:event, user_limit: 0)

    login_as user, scope: :user
    visit root_path
    click_on 'Ver Detalhes'

    expect(page).not_to have_link('Pedir para participar deste evento')
  end
end
