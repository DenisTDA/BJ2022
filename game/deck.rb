# frozen_string_literal: true

require_relative 'card'

class Deck
  attr_accessor :cards

  SUITS = ["\u2660", "\u2663", "\u2665", "\u2666"].freeze
  RANKS = %w[2 3 4 5 6 7 8 9 10 J D K T].freeze
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11].freeze

  def initialize
    @cards = []
    init_deck
    shuffle!
  end

  def init_deck
    SUITS.each do |suit|
      RANKS.each.with_index do |rank, index|
        cards << Card.new(suit, rank, VALUES[index])
      end
    end
  end

  def shuffle!
    cards.shuffle!
    cards.shuffle!
  end
end
