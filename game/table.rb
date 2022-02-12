# frozen_string_literal: true

class Table
  attr_accessor :players, :bank, :deck

  def initialize
    @players = []
    @bank = Bank.new
    @deck = Deck.new
  end

  def show_cards(cards)
    prn_face.each.with_index do |str, index_st|
      cards.each do |card|
        if card.opened?
          line = card.rank == '10' ? "\t| #{card.rank}#{card.suit} |" : "\t| #{card.rank} #{card.suit} |"
          index_st == 1 ? (print line) : (print "\t#{str}")
        else
          print "\t#{prn_shirt[index_st]}"
        end
      end
      puts
    end
  end

  def deal_cards
    players.first.take_card(deck.cards.pop)
    players.first.take_card(deck.cards.pop)
    players.last.take_card(deck.cards.pop)
    players.last.take_card(deck.cards.pop)
    players.last.open_cards
  end

  def new_deck
    self.deck = Deck.new
  end

  def add_player(player)
    players.append(player)
  end

  def score(player)
    if player.instance_of?(Player)
      puts "Score Player #{player.name}: [#{player.calc_cards}]"
    elsif player.cards[0].opened?
      puts "Score Player #{player.name}: [#{player.calc_cards}]"
    else
      puts "Score Player #{player.name}: [*******]"
    end
  end

  def bank_main
    puts "BANK = #{bank.on_play}"
  end

  def make_bids
    bank.get_bid(players.first.make_bid)
    bank.get_bid(players.last.make_bid)
  end

  def bank_player(player)
    p "Bank player #{player.name}: #{player.bank}"
  end

  def prn_face
    s1 = ' ----- '
    s2 = ''
    s3 = '|     |'
    s4 = '|     |'
    s5 = ' ----- '
    [s1, s2, s3, s4, s5]
  end

  def prn_shirt
    s1 = ' ----- '
    s2 = "|\u0e4f \u0e4f \u0e4f|"
    s3 = "|\u0e4f \u0e4f \u0e4f|"
    s4 = "|\u0e4f \u0e4f \u0e4f|"
    s5 = ' ----- '
    [s1, s2, s3, s4, s5]
  end
end
