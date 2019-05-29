require 'rails_helper'

feature 'User views event' do
  let(:user) { create(:user) }
  let(:has_requested) { 'Você já solicitou participar deste evento' }
  let(:vacancies_filled) { 'Todas as vagas estão preenchidas' }

  context 'when event is not full' do
    let(:event) { create(:event) }

    scenario 'after requesting to join' do
      create(:event_request, event: event, user: user)

      login_as(user, scope: :user)
      visit event_path(event)

      expect(page).to have_css('h4', text: has_requested)
      expect(page).not_to have_link('Pedir para participar deste evento')
      expect(page).not_to have_css('p', text: vacancies_filled)
    end

    scenario 'before requesting to join' do
      login_as(user, scope: :user)
      visit event_path(event)

      expect(page).not_to have_css('h4', text: has_requested)
      expect(page).to have_link('Pedir para participar deste evento')
      expect(page).not_to have_css('p', text: vacancies_filled)
    end

    scenario 'after being invited' do
      create(:event_invite, event: event, user: event.user, invitee: user)
      text = "Você foi convidado para este evento por #{event.user.nickname}"

      login_as(user, scope: :user)
      visit event_path(event)

      expect(page).to have_css('h4', text: text)
      expect(page).not_to have_link('Pedir para participar deste evento')
      expect(page).to have_button('Aceitar')
      expect(page).to have_button('Recusar')
    end

    scenario 'already participating' do
      create(:event_participation, event: event, user: user)
      ep2 = create(:event_participation, event: event)
      ep3 = create(:event_participation, event: event)

      login_as(user, scope: :user)
      visit event_path(event)

      expect(page).to have_css('strong', text: '(Você)', count: 1)
      expect(page).to have_content(user.nickname)
      expect(page).to have_content(ep2.user.nickname)
      expect(page).to have_content(ep3.user.nickname)
    end

    scenario 'without participating' do
      ep1 = create(:event_participation, event: event)
      ep2 = create(:event_participation, event: event)

      login_as(user, scope: :user)
      visit event_path(event)

      expect(page).not_to have_css('strong', text: '(Você)')
      expect(page).not_to have_content(user.nickname)
      expect(page).to have_content(ep1.user.nickname)
      expect(page).to have_content(ep2.user.nickname)
    end
  end

  context 'when event is full' do
    scenario 'before requesting to join' do
      event = create(:event, user_limit: 4)
      4.times { create(:event_participation, event: event) }

      login_as(user, scope: :user)
      visit root_path
      click_on 'Ver Detalhes'

      expect(page).not_to have_css('h4', text: has_requested)
      expect(page).not_to have_link('Pedir para participar deste evento')
      expect(page).to have_css('p', text: vacancies_filled)
    end
  end
end
