require "connect_four/board"
require "connect_four/player"

describe Player do

  describe "#move" do

    it "should raise a NotImplemented error" do

      player = Player.new

      expect{player.move}.to raise_error(NotImplementedError)

    end

  end

end

describe AI do

  let(:mock_board){Board.new}
  let(:ai) {AI.new(mock_board,0)}

  describe "#initialize" do

    it "should inherit from player class" do
      expect(ai).to be_a(Player)
    end

    it "should have correct player number 0" do
      ai = AI.new(mock_board,0)
      expect(ai.instance_variable_get(:@player_num)).to eq(0)
    end

    it "should have correct player number 1" do
      ai = AI.new(mock_board,1)
      expect(ai.instance_variable_get(:@player_num)).to eq(1)
    end

    it "should be able to accept a board" do
      new_board = [[1],[0,1],[0,0,1],[],[],[]]
      mock_board = Board.new(new_board)
      ai = AI.new(mock_board, 0)
      expect(ai.instance_variable_get(:@board)).to eq(mock_board)
    end

  end

  describe "#move" do

    context "winning moves" do

      it "should find a horzontal winning move" do
        new_board = Board.new([[],[],[0,1],[],[0,1],[0,1]])
        ai = AI.new(new_board, 0)
        expect(ai.move).to eq(3)

        new_board = Board.new([[0,1],[0,1],[],[0,1],[0,1],[0,1]])
        ai = AI.new(new_board, 0)
        expect(ai.move).to eq(2)
      end

      it "should find a vertical winning move" do
        new_board = Board.new([[0,0,0],[1,1,1],[],[],[],[]])
        ai = AI.new(new_board, 0)
        expect(ai.move).to eq(0)
      end

      it "should find a bottom-left to upper-right winning move" do
        new_board = Board.new([[0],[1,0],[0,1,0],[1,1,1],[],[]])
        ai = AI.new(new_board, 0)
        expect(ai.move).to eq(3)
      end

      it "should find a top-left to bottom-right winning move" do
        new_board = Board.new([[],[],[1,0,1],[0,1,0],[1,0],[0]])
        ai = AI.new(new_board, 0)
        expect(ai.move).to eq(2)
      end

      it "should prefer winning to not-losing" do
        new_board = Board.new([[0,0,0],[1,1,1],[0],[],[],[]])
        ai = AI.new(new_board, 1)
        expect(ai.move).to eq(1)
      end
    end

    context "loss avoiding moves" do
      it "should find a vertical loss preventing move" do
        new_board = Board.new([[0,0,0],[1,1],[1],[],[],[]])
        ai = AI.new(new_board, 1)
        expect(ai.move).to eq(0)
      end

      it "should find a horizontal loss preventing move" do
        new_board = Board.new([[0],[],[0,1],[],[0,1],[0,1]])
        ai = AI.new(new_board, 1)
        expect(ai.move).to eq(3)

        new_board = Board.new([[0,1,0],[0,1],[],[0,1],[0,1],[0,1]])
        ai = AI.new(new_board, 1)
        expect(ai.move).to eq(2)
      end

      it "should find a bottom-left to upper-right loss preventing move" do
        new_board = Board.new([[0],[1,0],[0,1,0],[1,1,1],[],[0]])
        ai = AI.new(new_board, 1)
        expect(ai.move).to eq(3)
      end

      it "should find a top-left to bottom-right loss preventing move" do
        new_board = Board.new([[],[],[1,0,1],[0,1,0],[1,0],[0,0]])
        ai = AI.new(new_board, 1)
        expect(ai.move).to eq(2)
      end
    end

  end

end

describe Player do

  let(:player_1) {Human.new}

  describe "#move" do

    it "should ask for input again one time if not between 1 and 6" do

      allow(player_1).to receive(:gets).and_return("7","1")
      expect(player_1.move).to eq(0)

    end

    it "should ask for input multiple times until valid" do

      allow(player_1).to receive(:gets).and_return("7","8","10","p","whasd", "3")
      expect(player_1.move).to eq(2)

    end

  end

end