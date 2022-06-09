class TicTacToe
  def initialize
    puts "\nTic - Tac - Toe \n\n"
    puts "     |   |  "
    puts " ----+---+----"
    puts "     |   |  "
    puts " ----+---+----"
    puts "     |   |  "
    puts " \n"
    puts "First Player"
    @player1 = Player.new
    puts "Second Player"
    @player2 = Player.new
    @players = [@player1, @player2]
    start
  end
  def start
    game = Game.new(@players)
    puts "#{@player1.name} has the symbol: #{@player1.symbol}"
    puts "#{@player2.name} has the symbol: #{@player2.symbol}"
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
      #until @choice =~ /[1-9]/  do
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

      while (@players[0].positions.length < 6) do
        @choice = @players[0].action
        @board.evaluate(@choice,@players[0])
        if (@board.flag == 1)
          @players.rotate!(-2)
        else
          @players.rotate!
        end

      end
  end
end

class Board
  attr_accessor :board, :flag
  def initialize
    @board = [1,2,3,4,5,6,7,8,9]
    display_board
  end
  def display_board
    puts "    |   |    "
    puts "  #{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts "----+---+----"
    puts "  #{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts "----+---+----"
    puts "  #{@board[6]} | #{@board[7]} | #{@board[8]}"
    puts "    |   |    \n\n"
  end
  def evaluate(choice,player)
    @flag=0
    if @board[choice-1] == choice
        @board[choice - 1] = player.symbol
        puts self.display_board
        player.positions << choice
        places = player.positions.sort.combination(3) do |comb|
            if (Game::WINNING.include?(comb))
              puts "#{player.name} is the winner!"
              puts "Start again? Y/N"
              answer = gets.chomp.upcase
              answer == "Y" ? TicTAcToe.new : exit
            end
        end
    else
        puts "#{choice} is occupied."
        @flag = 1
    end
  end
end


tic = TicTacToe.new