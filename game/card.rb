class Card
  attr_accessor :suit, :rank, :value, :status

  def initialize(suit, rank, value)
    @suit = suit
    @rank = rank
    @value = value
  end

  def open
    status = true
  end
  
  def close
    status = false
  end
  
  def front_side
    s1 = " ----- "
    s2 = "| #{rank} #{suit} |" 
    s3 = "|     |"
    s4 = "|     |"
    s5 = " ----- "
    front = [s1, s2, s3, s4, s5]
  end
  def shirt
    s1 = " ----- "
    s2 = "|\u0e4f \u0e4f \u0e4f|"
    s3 = "|\u0e4f \u0e4f \u0e4f|"
    s4 = "|\u0e4f \u0e4f \u0e4f|"
    s5 = " ----- "
    back = [s1, s2, s3, s4, s5]
  end
  #\u2623
end