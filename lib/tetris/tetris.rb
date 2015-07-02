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

class Board

  def initialize
    @game_board = []
    @block_falling = false
    @falling_x = 0
    @falling_y = 0
    @block_shape = []
    create_board
  end

  def create_board
    10.times do 
      @game_board << [0, 0, 0, 0, 0, 0]
    end
  end

  def add_block(block)
    #check if block exists at start - collision - cause game over
    @block_shape = block.shape
    @block_falling = true
    @falling_x = 0
    @falling_y = 0

    block.shape.each do |coords|
      @game_board[coords[0]][coords[1]] = "x"
    end
  end

  def block_fall
    
    @block_shape.each do |coords|
      @game_board[coords[0] + @falling_y][coords[1] + @falling_x] = 0
    end

    @falling_y += 1
    @block_shape.each do |coords|
      @game_board[coords[0] + @falling_y][coords[1] + @falling_x] = "x"
    end
  end

end

class Block

  attr_reader :shape



end

class SquareBlock < Block

  def initialize
    # Shape contains the coordinates for the new block?
    @shape = [[0,3],[0,4],[1,3],[1,4]]
  end

end



=begin

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