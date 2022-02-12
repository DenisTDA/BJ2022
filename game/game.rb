# frozen_string_literal: true

class Game
  include Validation

  BJ = 21
  FORMAT_NAME = /[a-zа-я]{3,}/i.freeze
  BANK = 100

  validate :name, :format, FORMAT_NAME

  def initialize
    @table = Table.new
  end

  def wellcome
    system('clear')
    puts 'Begin the game Blac Jack (in the reduction of Thinknetica!)'
    create_bot
    begin
      print 'Enter your name: '
      @name = gets.chomp.downcase.capitalize!
      raise unless valid?
    rescue StandardError
      p 'Incorrect input'
      retry
    end
    player = Player.new(@name, BJ)
    table.add_player(player)
  end

  def first_round
    table.deal_cards
    table.make_bids
    redraw
    self.menu = %w[1 2 3 0]
    puts "Your choice: \t1.Take a card\t 2.Pass\t 3.Open cards\t 0.Exit"
    print "Choice of player #{table.players.last.name} : "
    case choice_player
    when menu[0]
      table.players.last.take_card(table.deck.cards.pop)
      table.players.last.open_cards
      redraw
    when menu[1]
      table.players.last.pass
    when menu[2]
      table.players.first.open_cards
      redraw
      return false
    when menu[3]
      exit
    end
    sleep 2
  end

  def second_round
    system('clear')
    ibm = table.players.first
    puts "#{ibm.name} made a choice.."
    puts ibm.make_choice
    case ibm.make_choice
    when 'take card'
      table.players.first.take_card(table.deck.cards.pop)
    when 'pass'
      table.players.first.pass
    end
    sleep 2
  end

  def third_round
    if table.players.last.cards.size > 2
      table.players.first.open_cards
    else
      draw_fild
      self.menu = %w[1 3 0]
      puts "Your choice: \t1.Take a card\t 3.Open cards\t  0.Exit"
      print "Choice of player #{table.players.last.name} : "
      case choice_player
      when menu[0]
        table.players.last.take_card(table.deck.cards.pop)
        table.players.first.open_cards
        draw_fild
      when menu[1]
        table.players.first.open_cards
      when menu[2]
        exit
      end
    end
  end

  def end_game?
    return unless table.players.last.bank.zero? || table.players.first.bank.zero?

    if table.players.first.bank.zero?
      puts "The game is over!! player #{table.players.last.name} WIN!!"
    elsif table.players.last.bank.zero?
      puts "The game is over!! player #{table.players.first.name} WIN!!"
    end
    puts "Play again? (for play - 'y', for exit - 0 )"
    self.menu = %w[y 0]
    reset_all
    table.players.first.bank = BANK
    table.players.last.bank = BANK
    choice_player
  end

  def end_game_round
    redraw
    calc_score
    puts "For next round - Enter,\t For exit - 0"
    exit if gets.chomp == '0'
    reset_all
  end

  protected

  attr_accessor :table, :players, :menu

  def reset_all
    table.bank.reset
    table.players.first.cards_reset
    table.players.last.cards_reset
    table.new_deck
  end

  def create_bot
    name = 'IBM'
    hold = rand(17..19)
    bot = Ai.new(name, hold)
    table.add_player(bot)
  end

  def draw_fild
    view_part_table(table.players.first)
    table.bank_main
    view_part_table(table.players.last)
    table.bank.on_play
  end

  def redraw
    system('clear')
    draw_fild
  end

  def calc_score
    players = table.players
    player_1_score = table.players.first.calc_cards
    player_2_score = table.players.last.calc_cards

    if player_1_score == player_2_score || (player_1_score > BJ && player_2_score > BJ)
      puts 'Draw!!!'
      players.first.take_bank(table.bank.draw(players.size))
      players.last.take_bank(table.bank.draw(players.size))
    else
      if player_1_score > player_2_score && player_1_score <= BJ
        puts "Player #{players.first.name} win!!"
        players.first.take_bank(table.bank.on_play)
      end
      if player_1_score < player_2_score && player_2_score <= BJ
        puts "Player #{players.last.name} win!!"
        players.last.take_bank(table.bank.on_play)
      end
      if player_1_score > player_2_score && player_1_score > BJ
        puts "Player #{players.last.name} win!!"
        players.last.take_bank(table.bank.on_play)
      end
      if player_2_score > player_1_score && player_2_score > BJ
        puts "Player #{players.first.name} win!!"
        players.first.take_bank(table.bank.on_play)
      end
    end
  end

  def choice_player
    begin
      choice = gets.chomp
      raise unless menu.include?(choice)
    rescue StandardError
      puts 'Incorrect input! Try again.'
      retry
    end
    puts "Choice - #{choice}"
    choice == '0' ? exit : choice
  end

  def view_part_table(player)
    puts '=' * 50
    puts "Cards of player #{player.name}"
    table.show_cards(player.cards)
    table.score(player)
    table.bank_player(player)
    puts '=' * 50
  end
end
