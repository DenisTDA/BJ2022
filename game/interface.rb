class Interface
  def initialize
    @game = Game.new
    @menu = { '1' => :choice_take, '2' => :choice_pass,
              '3' => :choice_open, '0' => :exit }
  end

  attr_reader :game, :menu

  def wellcome
    system('clear')
    puts 'Begin the game Blac Jack (in the reduction of Thinknetica!)'
    print 'Enter your name: '
    game.init_players
  end

  def first_round
    game.initial_round
    chars = %w[1 2 3 0]
    puts "Your choice: \t1.Take a card\t 2.Pass\t 3.Open cards\t 0.Exit"
    print "Choice of player #{game.name_player_2} : "
    game.send(menu[game.choice_player(chars)], :player_2)
  end

  def second_round
    system('clear')
    puts "#{game.name_player_1} made a choice.."
    puts game.choice_ibm
    game.send(game.choice_ibm, :player_1)
    game.opening_up?
  end

  def third_round
    game.show_fild
    chars = %w[1 3 0]
    puts "Your choice: \t1.Take a card\t 3.Open cards\t 0.Exit"
    print "Choice of player #{game.name_player_2} : "
    game.send(menu[game.choice_player(chars)], :player_2)
  end

  def continue_game?
    game.final_score
    puts "For next round - Enter,\t For exit - 0"
    game.finish?
  end

  def new_game?
    puts "The game is over!! player #{game.name_winer} WIN!!"
    puts "Play again? (for play - 'y', for exit - 0 )"
    game.new_game?
  end
end
