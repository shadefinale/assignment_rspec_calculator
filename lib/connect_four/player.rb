# The player class is a base class for Human and AI.
# Ensures that Human and AI define their own "move" methods to be used by Game.
class Player
  def move
    raise NotImplemented
  end
end

class AI < Player

  def initialize(board, player_num)
    @board = board
    @player_num = player_num
  end

  # The AI searches for a winning move, then a "not-losing" move, then a random move.
  # Only searches one move deep.
  def move
    potential_move ||= winning_move
    potential_move ||= living_move
    potential_move ||= random_move
  end

  private

    # Returns a new board object with the same state as the real board.
    # This is important so we do not accidentally tamper with our
    # real board's state.
    def board_copy
      return Board.new(@board.state)
    end

    # Simulates and sees if there is a move that wins for the AI.
    def winning_move
      simulate_move(@player_num)
    end

    # Simulates and sees if there is a move that wins for the player.
    # The reason for this is if there is a move that wins for the player,
    # the AI can play it during it's own turn to avoid losing.
    def living_move
      simulate_move(opponent)
    end

    # Simulates all next moves of the selected player and returns if any
    # of those moves wins the game for said player.
    def simulate_move(player)
      moves = (0..5).to_a
      moves.each do |col|
        sim_board = board_copy
        unless sim_board.col_full?(col)
          sim_board.move([col,player])
          if sim_board.winner == player
            return col
          end
        end
      end
      return nil
    end

    # Method returns opposite player
    def opponent
      (@player_num - 1).abs
    end

    # Returns a random move in the case that there is no
    # good candidate for a not-losing or winning move.
    # Avoids full columns.
    def random_move
      moves = (0..5).to_a
      sim_board = board_copy
      moves.reject!{|col| sim_board.col_full?(col)}
      moves.sample
    end

end

class Human < Player
  # Prompts the player for a move until they put a valid choice in.
  def move
    puts "Input a move Col 1 to 6"
    col_to_add_to = gets.chomp.to_i
    col_to_add_to -= 1
    until col_to_add_to >= 0 && col_to_add_to < 6
      puts "Invalid column number, try again!"
      col_to_add_to = self.move
    end
    col_to_add_to

  end

end

