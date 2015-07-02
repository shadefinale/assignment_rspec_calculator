require './player.rb'
require './board.rb'

# The Game class manages the game flow.
class Game

  def initialize
    @players = []
  end

  # Main Game loop
  def play
    @board = Board.new
    instantiate_players # Are there two players or 1 vs ai?
    @turn = 0
    until(@board.winner || @board.full?)
      @board.move(valid_move)
      @board.display
      @turn += 1
    end
    @board.winner ? (puts "Player #{@board.winner + 1} wins!") : (puts "It's a draw!")

  end

  private
    # Convenient way to call the current player
    def current_player
      @players[@turn%2]
    end

    # Asks the player for a valid move
    # Keeps asking and displaying the current turn number and current player.
    # Returns the player's choice, and which player made that choice.
    def valid_move
      display_current_turn
    	col = prompt_legal_move
    	return col, @turn%2
    end

    # Displays the current turn and current player.
    def display_current_turn
      puts "Turn #{@turn + 1}, Player #{(@turn % 2) + 1}"
    end

    # Prompts the player until the player makes a move that is allowed
    # Disallows playing moves on full columns.
    def prompt_legal_move
      col = current_player.move
      while @board.col_full?(col)
        display_invalid_move_error
        col = current_player.move
      end
      return col
    end

    # Displays an error if the column is full, re-draws the board
    def display_invalid_move_error
      puts "That column is full."
      @board.display
    end

    # Populates our @players array with either two human players,
    # Or one ai and one human. Keeps track of the order of the players.
    def instantiate_players
      puts "How many players are there?"
      choice = gets.chomp
      if choice == "1"
        start_single_player_game
      else
        start_multiplayer_game
      end
    end

    def start_single_player_game
      puts "Do you want to go first or second?"
      choice = gets.chomp
      if choice == "1"
        @players = [Human.new, AI.new(@board, 1)]
      else
        @players = [AI.new(@board, 0), Human.new]
      end
    end

    def start_multiplayer_game
      @players = [Human.new, Human.new]
    end

end

game = Game.new

game.play