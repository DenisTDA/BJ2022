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

  def init_players
    create_bot
    begin
      @name = gets.chomp.downcase.capitalize!
      raise unless valid?
    rescue StandardError
      p 'Incorrect input'
      retry
    end
    player = Player.new(@name, BJ)
    table.add_player(player)
  end

  def initial_round
    table.deal_cards
    table.make_bids
    redraw
  end

  def choice_take(player)
    table.players.first.take_card(table.deck.cards.pop) if player == :player_1
    if player == :player_2
      table.players.last.take_card(table.deck.cards.pop)
      table.players.last.open_cards
      redraw
    end
    sleep 2
  end

  def choice_pass(player)
    table.players.last.pass if player == :player_2
    table.players.first.pass if player == :player_1
    sleep 2
  end

  def choice_open(_player)
    table.players.first.open_cards
    redraw
    sleep 2
    SKIP_SECOND_ROUND
  end

  def name_player_2
    table.players.last.name
  end

  def name_player_1
    table.players.first.name
  end

  def choice_ibm
    table.players.first.make_choice
  end

  def choice_player(menu)
    begin
      choice = gets.chomp
      raise unless menu.include?(choice)
    rescue StandardError
      puts 'Incorrect input! Try again.'
      retry
    end
    puts "Choice - #{choice}"
    choice.eql?('0') ? exit : choice
  end

  def show_fild
    draw_fild
  end

  def opening_up?
    if table.players.last.cards.size > 2
      table.players.first.open_cards
      false
    else
      true
    end
  end

  def name_winer
    if table.players.first.bank.zero?
      name = table.players.last.name
    elsif table.players.last.bank.zero?
      name = table.players.first.name
    end
    name
  end

  def new_game?
    self.menu = %w[y 0]
    reset_all
    table.players.first.bank = BANK
    table.players.last.bank = BANK
    choice_player(menu)
  end

  def final_score
    table.players.first.open_cards
    redraw
    calc_score
  end

  def finish?
    exit if gets.chomp == '0'
    reset_all
    table.players.last.bank.zero? || table.players.first.bank.zero?
  end

  protected

  attr_accessor :table, :players, :menu

  SKIP_SECOND_ROUND = false

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

  def view_part_table(player)
    puts '=' * 50
    puts "Cards of player #{player.name}"
    table.show_cards(player.cards)
    table.score(player)
    table.bank_player(player)
    puts '=' * 50
  end
end
