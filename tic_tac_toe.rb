class TicTacToe
  def initialize
    puts "\nTic - Tac - Toe \n"
    puts "\n\t_|_|_\n\t_|_|_\n\t | | \n"
    puts "\nFirst Player"
    @player1 = Player.new
    puts "\nSecond Player"
    @player2 = Player.new
    @players = [@player1, @player2]
    start
  end

  def start
    game = Game.new(@players)
    puts "#{@player1.name} has the symbol: #{@player1.symbol}\n\n"
    puts "#{@player2.name} has the symbol: #{@player2.symbol}\n\n"
    game.play
  end
end

class Player
  attr_accessor :name, :symbol, :positions
  def initialize
    print "Enter player's name: "
    @name = gets.chomp.upcase
    print "Choose player's symbol:"
    @symbol = gets.chomp.upcase[0]
    @positions = []
  end

  def action
    @choice = 0
        print "#{@name} where do you put your symbol? "
        return @choice = gets.chomp.to_i
  end

end

class Game
  attr_accessor :board, :player1, :player2
  WINNING = [ [1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7] ].freeze

  def initialize(players)
    @board = Board.new
    @players = players
  end

  def play
      movements = 0
      while  movements < 9 do
        @choice = @players[0].action
        @board.evaluate(@choice,@players[0])
        if (@board.invalid_move == 1)
          @players.rotate!(-2)
        else
          @players.rotate!
        end
        movements = movements + 1
      end
    if movements == 9
      puts "No winner!"
      puts "Start again? Y/N"
      answer = gets.chomp.upcase
      answer == "Y" ? tic = TicTacToe.new : exit
    end
  end
end

class Board
  attr_accessor :board, :invalid_move
  def initialize
    @board = [1,2,3,4,5,6,7,8,9]
    display_board
  end
  def display_board
    puts "\n    |   |    "
    puts "  #{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts "----+---+----"
    puts "  #{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts "----+---+----"
    puts "  #{@board[6]} | #{@board[7]} | #{@board[8]}"
    puts "    |   |    \n\n"
  end
  def evaluate(choice,player)
    @invalid_move=0
    if @board[choice-1] == choice
        @board[choice - 1] = player.symbol
        puts self.display_board
        player.positions << choice
        places = player.positions.sort.combination(3) do |comb|
            if (Game::WINNING.include?(comb))
              puts "#{player.name} is the winner!"
              puts "Start again? Y/N"
              answer = gets.chomp.upcase
              answer == "Y" ? TicTacToe.new : exit
            end
        end
    else
        puts "#{choice} is occupied."
        @invalid_move = 1
    end
  end
end

TicTacToe.new