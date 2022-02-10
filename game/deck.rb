require_relative 'card'

class Deck
  attr_accessor :cards
  
  SUITS = ["\u2660", "\u2663", "\u2665", "\u2666"]
  RANKS = %w[2 3 4 5 6 7 8 9 10 J D K T]
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11]

  def initialize
    @cards = []
    init_deck
    self.shuffle!
  end

  def init_deck
    SUITS.each do |suit|
      RANKS.each.with_index do |rank, index|
        self.cards << Card.new(suit, rank, VALUES[index])
      end
    end
  end

  def hand_over_card
    self.cards.pop
  end

  def shuffle!
    self.cards.shuffle!(rand(3..5))
  end
end
