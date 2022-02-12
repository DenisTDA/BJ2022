# frozen_string_literal: true

class Bank
  EMPTY = 0

  def initialize
    @bank = EMPTY
  end

  def get_bid(bid)
    self.bank += bid
  end

  def on_play
    self.bank
  end

  def draw(count_players)
    self.bank / count_players
  end

  def reset
    self.bank = EMPTY
  end

  protected

  attr_accessor :bank
end
