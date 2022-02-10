class Table
  attr_accessor :players

  @players = []
  @bank = 0

  def calc
  end

  def show_cards (cards)
    self.prn_face.each.with_index do |str, index_st| 
      cards.each do |card| 
        if card.open?
          card.rank == '10' ? line = "\t| #{card.rank}#{card.suit} |" : line = "\t| #{card.rank} #{card.suit} |"
          index_st == 1 ? (print line)  : (print "\t#{str}") 
        else
          print "\t#{self.prn_shirt[index_st]}"
        end
      end
      puts
    end
  end
          

  def prn_face
    s1 = " ----- "
    s2 = "" 
    s3 = "|     |"
    s4 = "|     |"
    s5 = " ----- "
    side = [s1, s2, s3, s4, s5]
  end
  def prn_shirt
      s1 = " ----- "
      s2 = "|\u0e4f \u0e4f \u0e4f|"
      s3 = "|\u0e4f \u0e4f \u0e4f|"
      s4 = "|\u0e4f \u0e4f \u0e4f|"
      s5 = " ----- "
      side = [s1, s2, s3, s4, s5]
  end
end