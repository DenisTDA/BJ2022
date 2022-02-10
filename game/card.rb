class Card
  attr_accessor :suit, :rank, :value, :status

  def initialize(suit, rank, value)
    @suit = suit
    @rank = rank
    @value = value
    status = OPEN
  end

  def open?
    status
  end
  
  def close?
    !status 
  end

  protected
  OPEN = true
  HIDDEN = false
end