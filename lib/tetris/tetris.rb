=begin

Board
  block_falling boolean
  Array of Arrays
  Represents Game State
  Updates and moves all pieces
  ######Need to check for collisions
  ######Need to check for lines cleared
    if game_board[row] == ["X","X","X","X","X","X"]
      move all the upper rows!?
      game_board[row] == ["0","0","0","0","0""0"]?
      assign and return a score to the play

  board.add_block
    block.each do |value|
      game_board[value] = X
    end
  end

# Block moving down
# . can be nil or 0 or whatever. Just . for clarity
#keey track of x and y position of each falling block
#reset x and y position everytime we respawn a new block

=end

# Maintains state of board.
class Board

  BOARD_WIDTH = 10
  BOARD_HEIGHT = 15

  attr_accessor :state

  def initialize
    @state = []
    @state = initialize_board_state
    @current_block = nil
  end

  def initialize_board_state
    state = []
    BOARD_HEIGHT.times do
      state << Array.new(BOARD_WIDTH) {|column| column = 0}
    end
    return state
  end

  def add_block(block)
    @current_block = block
  end

  def place_block
    if @current_block
      @current_block.current_position.each do |pos|
        @state[pos[1]][pos[0]] = 1
      end
    end
    @current_block = nil
  end


  # Checks if position moving to is out of bounds or full.
  def full?(x, y)
    x >= BOARD_WIDTH || x < 0 || y >= BOARD_HEIGHT || (@state[x][y] == 1)
  end

  def render
    temp_add_current_block
    (BOARD_HEIGHT-1).downto(0) do |y|
      p @state[y]
    end
    temp_remove_current_block
  end

  def temp_add_current_block
    if @current_block
      @current_block.current_position.each do |pos|
        @state[pos[1]][pos[0]] = 1
      end
    end
  end

  def temp_remove_current_block
    if @current_block
      @current_block.current_position.each do |pos|
        @state[pos[1]][pos[0]] = 0
      end
    end
  end

end

# Maintains state of individual block.
class Block

  attr_reader :shape, :x_pos, :y_pos

  def initialize(board)
    @board = board
    @x_pos = 0
    @y_pos = 0
    @shape = [[0,0],[0,1],[1,0],[1,1]]
  end

  # Returns each individual square of the shape.

  def move(x_offset, y_offset)
    unless collides?(x_offset, y_offset)
      @x_pos += x_offset
      @y_pos += y_offset
    end
  end

  # This checks if there is a collision/out of bounds
  # by looking at the squares that we're trying to move to.
  def collides?(x_dir, y_dir)
    @shape.any? {|square| @board.full?(square[0] + @x_pos + x_dir, square[1] + @y_pos + y_dir)}
  end

  def current_position
    @shape.map{|square| [square[0] + @x_pos, square[1] + @y_pos]}
  end



end

class SquareBlock < Block

  def initialize
    # Shape contains the coordinates for the new block?
    @shape = [[0,3],[0,4],[1,3],[1,4]]
  end

end
=begin
board = Board.new
block = Block.new(board)

board.add_block(block)
board.render

#board.move_current_block(0,-1)


board.render





  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,X,X,.,.]
  [.,.,X,X,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]

      VVVV
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,X,X,.,.]
  [.,.,X,X,.,.]
  [.,.,.,.,.,.]


# New Square Block
# Square is [[0,3],[0,4],[1,3],[1,4]]

  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,X,X,.,.]
  [.,.,X,X,.,.]

      VVVV

  [.,.,X,X,.,.]
  [.,.,X,X,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,X,X,.,.]
  [.,.,X,X,.,.]

# New L Block
# L is [[0,3],[1,3],[2,3],[2,4]]

  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,X,X,.,.]
  [.,.,X,X,.,.]

      VVVV

  [.,.,X,.,.,.]
  [.,.,X,.,.,.]
  [.,.,X,X,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,.,.,.,.]
  [.,.,X,X,.,.]
  [.,.,X,X,.,.]

shapes?

                X
XX XXX XXXX XX  X
XX X         XX XX

class Block

class SquareBlock < Block

  def initialize
    # Shape contains the coordinates for the new block?
    @shape = [[0,3],[0,4],[1,3],[1,4]]
  end
end

Renderer
  Displays board state to the player
  Doesn't display the top 3 rows (so the blocks look like they fall from the sky)

Input
  Parses player input


Player
  Hold the score

Game
  Take input
  Update Board
  Redraw Board

=end