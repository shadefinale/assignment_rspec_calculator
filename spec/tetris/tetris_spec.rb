require_relative '../../lib/tetris/tetris.rb'

describe Board do

  let(:board) {Board.new}
  let(:block) {Block.new(board)}

  it 'should properly add block' do
    board.add_block(block)
    expect(board.instance_variable_get(:@current_block)).not_to be_nil
  end

end

describe Block do
  let(:board) {Board.new}
  let(:block) {Block.new(board)}

  describe "#move" do

    it 'should properly let block move' do
      block.move(0,1)
      expect(block.current_position).to eq([[0,1],[0,2],[1,1],[1,2]])
    end

    it 'should not move if there is a block in the way' do
      board.state[0][3] = 1
      board.state[0][4] = 1
      board.state[1][3] = 1
      board.state[1][4] = 1

      block.move(0,1)
      expect(block.current_position).to eq([[0,1],[0,2],[1,1],[1,2]])

      block.move(0,1)
      expect(block.current_position).to eq([[0,1],[0,2],[1,1],[1,2]])
    end

    context 'bounds' do
      it "should not go out of bounds diagonally" do
        999.times do
          block.move(1,1)
        end
        expect(block.current_position).to eq([[8,8],[8,9],[9,8],[9,9]])
      end

      it "should not go out of bounds vertically" do
        999.times do
          block.move(0,1)
        end
        expect(block.current_position).to eq([[0,13],[0,14],[1,13],[1,14]])
      end

      it "should not go out of bounds horizontally" do
        999.times do
          block.move(1,0)
        end
        expect(block.current_position).to eq([[8,0],[8,1],[9,0],[9,1]])
      end
    end
  end
end