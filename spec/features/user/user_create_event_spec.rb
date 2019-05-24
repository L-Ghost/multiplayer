require 'rails_helper'

feature 'User create Event' do
  desc = 'Noite com os amigos do curso para beber cerveja e jogar Mario Kart'

  scenario 'for a physical location' do
    user = create(:user)
    game = create(:game, name: 'Mario Kart 8')
    platform = create(:platform, name: 'Nintendo Switch')
    create(:game_release, game: game, platform: platform)
    create(:game_user, game: game, user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Quero criar um novo Evento'
    fill_in 'Título', with: 'Noite do Mario Kart na Paulista'
    select 'Mario Kart 8 - Nintendo Switch', from: 'Selecione o Jogo'
    fill_in 'Descrição', with: desc
    select '25', from: 'event_event_date_3i'
    select 'Abril', from: 'event_event_date_2i'
    select '2019', from: 'event_event_date_1i'
    fill_in 'Limite de Usuários', with: '8'
    choose('Presencial')
    fill_in 'Local', with: 'Avenida Paulista, 1000'
    click_on 'Criar Evento'

    expect(page).to have_content('Seu evento foi criado')
    expect(page).to have_css('h2', text: 'Noite do Mario Kart na Paulista')
    expect(page).to have_content('Data: 25/04/2019')
    expect(page).to have_content('Local: Avenida Paulista, 1000')
    expect(page).to have_content('Total Participantes: 1')
    expect(page).to have_content('Máximo Participantes: 8')
  end
end
