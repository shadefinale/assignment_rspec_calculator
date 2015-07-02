# The board class manages the game state, and renders it to the player.
class Board
  attr_reader :state

  # This initializer allows us to easily make
  # new board objects with the same internal state but
  # with different object ids. (Deep Duplication)
  # The default state is an array of columns
  def initialize(state = [[],[],[],[],[],[]])
    @state = []
    state.each do |col|
      @state << col.dup
    end
  end

  # To make a move, we simply push it on top of the column.
  # The args array takes the column number, and the player who
  # is making the move.
  def move(args)
    @state[args[0]] << args[1]
  end

  # Will return the first type of win condition that is not nil.
  # If no player wins under any of these conditions, returns nil.
  def winner
    horizontal_winner ||
    vertical_winner ||
    backslash_winner ||
    forwardslash_winner
  end

  def full?
    return @state.reduce(0){|acc, col| acc += col.length} >= 36
  end

  # Visually represents the board to the player.
  def display
    # Board width is a variable so we don't have constants all over this method
    board_width = 33
    puts ""
    print " " * ((board_width - 5)/2)
    print "Board"
    puts ""
    print "-" * board_width
    puts ""
    5.downto(0) do |idx|
      0.upto(5) do |pos|
        print " | "
        @state[pos][idx]? (print "#{pretty_disc(@state[pos][idx])} ") : (print "  ")
      end
      print " | "
      puts ""
      print "-" * board_width
      puts ""
    end
  end

  def col_full?(col_no)
    @state[col_no].length > 5
  end

  private

    def pretty_disc(color)
      (color == 1)? "○" : "●"
    end

    def horizontal_winner
      0.upto(5) do |row|
        0.upto(2) do |col|
          if (@state[0 + col][row] == @state[1 + col][row]) &&
          (@state[0 + col][row] == @state[2 + col][row]) &&
          (@state[0 + col][row] == @state[3 + col][row])
            return @state[col][row] unless @state[col][row].nil?
          end
        end
      end
      return nil
    end

    def vertical_winner
      0.upto(5) do |col|
        0.upto(2) do |row|
          if (@state[col][0 + row] == @state[col][1 + row]) &&
            (@state[col][0 + row] == @state[col][2 + row]) &&
            (@state[col][0 + row] == @state[col][3 + row])
            return @state[col][row] unless @state[col][row].nil?
          end
        end
      end
      return nil
    end

    def backslash_winner
      5.downto(3) do |row|
        0.upto(2) do |col|
          if (@state[col][row] == @state[col + 1][row - 1]) &&
            (@state[col][row] == @state[col + 2][row - 2]) &&
            (@state[col][row] == @state[col + 3][row - 3])
            return @state[col][row] unless @state[col][row].nil?
          end
        end
      end

      return nil
    end

    def forwardslash_winner
      0.upto(2) do |row|
        0.upto(2) do |col|
          if (@state[col][row] == @state[1 + col][1 + row]) &&
            (@state[col][row] == @state[2 + col][2 + row]) &&
            (@state[col][row] == @state[3 + col][3 + row])
            return @state[col][row] unless @state[col][row].nil?
          end
        end
      end
      return nil
    end
end

