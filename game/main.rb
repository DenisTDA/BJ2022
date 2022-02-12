# frozen_string_literal: true

require_relative 'validation'
require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'ai'
require_relative 'bank'
require_relative 'table'
require_relative 'game'

game = Game.new
def init_game(game)
  game.wellcome
  loop do
    if game.first_round
      game.second_round
      game.third_round
    end
    game.end_game_round
    game.end_game?
  end
end
init_game(game)
