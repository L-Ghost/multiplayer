require 'rails_helper'

feature 'User create Event' do
  scenario 'for a physical location' do
    user = create(:user)
    game = create(:game, name: 'Mario Kart 8')
    create(:game_user, game: game, user: user)
    platform = create(:platform, name: 'Nintendo Switch')
    create(:game_platform, game: game, platform: platform)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Quero criar um novo Evento'
    fill_in 'Título', with: 'Noite do Mario Kart na Paulista'
    select 'Mario Kart 8 - Nintendo Switch', from: 'Selecione o Jogo'
    fill_in 'Descrição', with: 'Noite com os amigos do curso para beber cerveja e jogar Mario Kart'
    fill_in 'Data do Evento', with: '25/04/2019'
    fill_in 'Limite de Usuários', with: '8'
    select 'Presencial', from: 'Tipo do Evento'
    fill_in 'Local', with: 'Avenida Paulista, 1000'
    click_on 'Criar Evento'

    expect(page).to have_content('Seu evento foi criado')
    expect(page).to have_content('h2', 'Noite do Mario Kart na Paulista')
    expect(page).to have_content('Data: 25/04/2019')
    expect(page).to have_content('Local: Avenida Paulista, 1000')
    expect(page).to have_content('Total Participantes: 1')
    expect(page).to have_content('Máximo Participantes: 8')
    expect(page).to have_link('Convidar Jogadores para este Evento')
  end
end