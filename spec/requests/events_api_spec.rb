require 'rails_helper'

RSpec.describe 'Events API' do
  describe 'list events' do
    it 'should list all events' do
      create(:event, title: 'Jogatina')
      create(:event, title: 'Jogo dos Top')
      create(:event, title: 'Jogatina Noob')

      # chamada para a api
      get '/api/v1/events'

      # expectativas
      expect(response.status).to eq(200)
      expect(response.body).to include 'Jogatina'
      expect(response.body).to include 'Jogo dos Top'
      expect(response.body).to include 'Jogatina Noob'
    end
  end

  describe 'get event' do
    it 'should show info about an event' do
      user = create(:user, nickname: 'Rockman2000')
      title = 'Noite Mega Man Legends'
      description = 'Noite para terminar todos os jogos da saga'
      location = 'Avenida Consolação, 2000'
      platform = create(:platform, name: 'Playstation')
      game = create(:game, name: 'Mega Man Legends')
      game_platform = create(:game_platform, game: game, platform: platform)
      event = create(
        :event,
        user: user, game_platform: game_platform,
        title: title, description: description, event_location: location
      )

      get '/api/v1/events/' + event.id.to_s

      expect(response.status).to eq(200)
      expect(response.body).to include(title)
      expect(response.body).to include(description)
      expect(response.body).to include(user.nickname)
      expect(response.body).to include(location)
      expect(response.body).to include(game.name)
      expect(response.body).to include(platform.name)
    end

    it 'should show info about an event that does not exist' do
      get '/api/v1/events/999'

      expect(response.status).to eq(404)
      expect(response.body).to include 'Não existe um evento com o ID informado'
    end
  end
end
