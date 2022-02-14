# frozen_string_literal: true

require_relative 'validation'
require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'ai'
require_relative 'bank'
require_relative 'table'
require_relative 'game'
require_relative 'interface'

interface = Interface.new
interface.wellcome
loop do
  interface.third_round if interface.first_round && interface.second_round
  interface.new_game? if interface.continue_game?
end
