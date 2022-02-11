class Bank

  EMPTY = 0

  def initialize
    @bank = EMPTY
  end

  def get_bid(bid)
    self.bank += bid
  end

  def on_play
    slef.bank
  end

  def for_win
    self.bank
  end

  def draw(count_players)
    slef.bank / count_players
  end

  def reset 
    self.bank = EMPTY
  end

  protected
  attr_accessor :bank
end