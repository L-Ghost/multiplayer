require 'rails_helper'

feature 'User search events' do
  let(:user) { create(:user) }

  context 'event is found' do
    let(:event) { create(:event, title: 'Jogatina') }

    scenario 'by title' do
      login_as(user, scope: :user)
      visit root_path
      click_on 'Encontrar Eventos'
      fill_in 'Procurar por:', with: event.title
      click_on 'Pesquisar'

      expect(current_path).to eq search_events_path
      expect(page).to have_css('h1', text: 'Pesquisar Eventos')
      expect(page).to have_css('p', text: event.title)
      expect(page).to have_content('Foi encontrado 1 evento')
    end

    scenario 'by part of title' do
      login_as(user, scope: :user)
      visit search_events_path
      fill_in 'Procurar por:', with: event.title[0..3]
      click_on 'Pesquisar'

      expect(current_path).to eq search_events_path
      expect(page).to have_css('h1', text: 'Pesquisar Eventos')
      expect(page).to have_css('p', text: event.title)
      expect(page).to have_content('Foi encontrado 1 evento')
    end

    scenario 'and viewed' do
      login_as(user, scope: :user)
      visit search_events_path
      fill_in 'Procurar por:', with: event.title
      click_on 'Pesquisar'
      click_on event.title

      expect(current_path).to eq event_path(event)
      expect(page).to have_css('h2', text: event.title)
    end
  end

  context 'event is not found' do
    scenario 'because title is different' do
      event = create(:event, title: 'Jogatina')

      login_as(user, scope: :user)
      visit search_events_path
      fill_in 'Procurar por:', with: 'Batata'
      click_on 'Pesquisar'

      expect(current_path).to eq search_events_path
      expect(page).to have_css('h1', text: 'Pesquisar Eventos')
      expect(page).not_to have_css('p', text: event.title)
      expect(page).to have_content('Nenhum evento encontrado')
    end
  end
end
