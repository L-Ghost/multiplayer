require 'rails_helper'

RSpec.describe 'Games API' do
  describe 'list games' do
    it 'should list all games' do
      create(:game, name: 'God of War')
      create(:game, name: 'Life is Strange')

      get '/api/v1/games'
      result = JSON.parse(response.body)

      expect(result.count).to eq 2
      expect(response.status).to eq 200
      expect(response.body).to include 'God of War'
      expect(response.body).to include 'Life is Strange'
    end

    it 'should delete a game' do
      game = create(:game, name: 'God of War')

      delete '/api/v1/games/' + game.id.to_s

      expect(response.status).to eq 200
      expect(response.body).to include "Game #{game.name} deletado com sucesso"
    end

    it 'should not delete a game that does not exist' do
      delete '/api/v1/games/999'

      expect(response.status).to eq 404
      expect(response.body).to include 'Game não existe'
    end
  end
end
