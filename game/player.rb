class Player

  BANK = 100
  BID = 10
  BJ = 21
  T = 11
  T_1 = 1

  attr_accessor :bank, :cards

  def initialize(name = '', hold = 17, )
    @name, @hold, @bank, @cads = name, hold, BANK, []
  end

  def make_beat
    if BID > self.bank  
      return "Not enouhg mony!"
    else 
      self.bank -= BID
      BID
    end
  end

  def take_bank(win_bank)
    self.bank += win_bank
  end
  
  def pass?
    self.hold >= self.calc_cards
  end

  def take_card(cards)
    self.cads.union(card)
  end

  def open_cards?
    self.calc_cards >= BJ
  end

  def calc_cards
    summ = 0
    self.cads.each do |card|
      if card.value == T 
        (summ + T) <= BJ ? summ += T : summ += T_1
      else
        sum += card.value
      end
    end
    summ
  end

  protected
  attr_reader :hold, :name

end