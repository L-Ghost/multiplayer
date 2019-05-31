require 'rails_helper'

feature 'User adds games to profile' do
  let(:user) { create(:user) }
  let(:game) { create(:game) }

  context 'from game page' do
    scenario 'successfully' do
      login_as(user, scope: :user)
      visit game_path(game)
      click_on 'Adicionar ao meu Perfil'

      expect(current_path).to eq(game_path(game))
      expect(page).to have_content('Este jogo foi vinculado ao seu perfil')
      expect(page).not_to have_link('Adicionar ao meu Perfil')
      expect(GameUser.count).to eq(1)
    end

    scenario 'and checks game added' do
      login_as(user, scope: :user)
      visit game_path(game)
      click_on 'Adicionar ao meu Perfil'
      visit user_path(user)

      expect(page).to have_css('h3', text: 'Meus Jogos')
      expect(page).to have_link(game.name)
    end

    scenario 'only if game is not already added' do
      create(:game_user, game: game, user: user)

      login_as(user, scope: :user)
      visit game_path(game)
      expect(page).not_to have_link('Adicionar ao meu Perfil')
    end
  end

  context 'from timeline' do
    scenario 'successfully' do
      game = create(:game)
      another_game = create(:game)

      login_as(user, scope: :user)
      visit root_path
      click_on 'Adicionar ao meu Perfil', match: :first
      visit user_path(user)

      expect(page).to have_link(game.name)
      expect(page).not_to have_link(another_game.name)
    end

    scenario 'until all games are added' do
      create_list(:game, 3)

      login_as(user, scope: :user)
      visit root_path
      click_on 'Adicionar ao meu Perfil', match: :first
      visit root_path
      click_on 'Adicionar ao meu Perfil', match: :first
      visit root_path
      click_on 'Adicionar ao meu Perfil'
      visit root_path

      expect(page).not_to have_link('Adicionar ao meu Perfil')
      expect(GameUser.count).to eq(3)
    end

    scenario 'only if game is not already added' do
      create_list(:game, 2)
      create(:game_user, game: game, user: user)

      login_as(user, scope: :user)
      visit root_path

      expect(page).to have_link('Adicionar ao meu Perfil', count: 2)
    end
  end

  context 'from game search' do
    scenario 'successfully' do
      another_game = create(:game)

      login_as(user, scope: :user)
      visit root_path
      click_on 'Encontrar Jogos'
      fill_in 'Procurar por:', with: another_game.name
      click_on 'Pesquisar'
      click_on 'Adicionar ao meu Perfil', match: :first
      visit user_path(user)

      expect(page).not_to have_link(game.name)
      expect(page).to have_link(another_game.name)
    end

    scenario 'only if game is not already added' do
      create(:game_user, game: game, user: user)

      login_as(user, scope: :user)
      visit root_path
      click_on 'Encontrar Jogos'
      fill_in 'Procurar por:', with: game.name
      click_on 'Pesquisar'

      expect(page).not_to have_link('Adicionar ao meu Perfil')
    end
  end
end
