require 'rails_helper'

feature 'User search games' do
  let(:user) { create(:user) }

  scenario 'from home page' do
    mt = create(:game, name: 'Mario Tennis Aces')
    mg = create(:game, name: 'Mario Golf 64')
    mk = create(:game, name: 'Mario Kart Super Circuit')
    sf = create(:game, name: 'Street Fighter 3')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Encontrar Jogos'
    fill_in 'Procurar por:', with: 'Mario'
    click_on 'Pesquisar'

    expect(page).to have_css('h1', text: 'Pesquisar Jogos')
    expect(page).to have_link(mt.name)
    expect(page).to have_link(mg.name)
    expect(page).to have_link(mk.name)
    expect(page).not_to have_link(sf.name)
    expect(page).to have_content('Foram encontrados 3 jogos')
  end

  scenario 'from its own page' do
    oa = create(:game, name: 'Zelda Oracle of Ages')
    os = create(:game, name: 'Zelda Oracle of Seasons')
    mz = create(:game, name: 'Mega Man Zero 2')

    login_as(user, scope: :user)
    visit user_path(user)
    click_on 'Adicionar Jogos ao Meu Perfil'
    fill_in 'Procurar por:', with: 'zelda'
    click_on 'Pesquisar'

    expect(page).to have_css('h1', text: 'Pesquisar Jogos')
    expect(page).to have_link(oa.name)
    expect(page).to have_link(os.name)
    expect(page).not_to have_link(mz.name)
    expect(page).to have_content('Foram encontrados 2 jogos')
  end

  scenario 'and finds no results' do
    cs = create(:game, name: 'Castlevania')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Encontrar Jogos'
    fill_in 'Procurar por:', with: 'Metroid'
    click_on 'Pesquisar'

    expect(page).to have_css('h1', text: 'Pesquisar Jogos')
    expect(page).not_to have_link(cs.name)
    expect(page).to have_content('Nenhum jogo encontrado')
  end

  scenario 'only after clicking on search buton' do
    cs = create(:game, name: 'Castlevania')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Encontrar Jogos'

    expect(page).to have_css('h1', text: 'Pesquisar Jogos')
    expect(page).not_to have_link(cs.name)
    expect(page).not_to have_content('Foram encontrados')
    expect(page).to have_content('Nenhum jogo encontrado')
  end
end
