require 'connect_four/board'

describe Board do

  context "New Empty Board" do

    let(:board){Board.new}

    describe "#initialize" do

      it "should initialize as a Board" do
        expect(board).to be_a(Board)
      end

      it "should be empty" do
        0.upto(6) do |idx|
          expect(board.state[idx]).to eq([])
        end
      end
    end

  end

  context "New Copied Board" do

    let(:board){Board.new([[0],[0,1],[1,0,1],[],[],[],[]])}

    describe "#initialize" do
      it "should initialize as a Board" do
        expect(board).to be_a(Board)
      end

      it "shouldn't be empty" do
        expect(board.state[0]).to eq([0])
        expect(board.state[1]).to eq([0,1])
        expect(board.state[2]).to eq([1,0,1])
      end
    end

  end

  context "Board methods" do
    let(:board){Board.new}

    describe "#move" do

      it "should put proper player move in proper column" do
        board.move([0,0])
        expect(board.state[0][0]).to eq(0)
        expect(board.state[0]).to eq([0])
      end

      it "shouldn't put improper player in proper column" do
        board.move([0,1])
        expect(board.state[0][0]).not_to eq(0)
        expect(board.state[0]).to eq([1])
      end
      it "should not put move in wrong column" do
        board.move([1,0])
        expect(board.state[0][0]).to be_nil
        expect(board.state[0]).to eq([])
      end
    end

    describe "#col_full?" do

      it "should return true if column is full" do
        board.move([0,0])
        board.move([0,1])
        board.move([0,0])
        board.move([0,1])
        board.move([0,0])
        board.move([0,1])

        expect(board.col_full?(0)).to be true
      end

      it "should return false if column is not full" do
        board.move([0,0])
        board.move([0,1])
        board.move([0,0])
        board.move([0,1])
        board.move([0,0])

        expect(board.col_full?(0)).to be false
      end

    end

    describe "#full?" do

      let(:board){Board.new([[1,0,1,0,1,0],
                             [1,0,1,0,1,0],
                             [1,0,1,0,1,0],
                             [0,1,0,1,0,1],
                             [0,1,0,1,0,1],
                             [1,0,1,0,1,0],
                             [0,1,0,1,0]])}

      it "should return false if board is not full" do
        expect(board.full?).to be false
      end

      it "should be true if board is full" do
        board.move([6,0])
        expect(board.full?).to be true
      end
    end

    describe "#winner" do

      it "should return nil if no winner" do
        expect(board.winner).to be_nil
      end

      context "horizontal_winner" do
        let(:board) {Board.new([[],[],[0,1],[],[0,1],[0,1],[]])}
        it "shouldn't return winner if not horizontal winner" do
          expect(board.winner).to be_nil
        end

        it "should return '0' as winner if horizontal winner" do
          board.move([3,0])
          expect(board.winner).to eq(0)
        end

        it "should return '1' as winner if horizontal winner" do
          board.move([0,0])
          board.move([3,1])
          board.move([0,0])
          board.move([3,1])
          expect(board.winner).to eq(1)
        end

        it "should return winner if connect more than 4 horizontally" do
          board = Board.new([[0,1],[0,1],[],[0,1],[0,1],[0,1]])
          board.move([2,0])
          expect(board.winner).not_to be_nil
        end

      end

      context "vertical_winner" do

        let(:board_vertical) {Board.new([[0,0,0],[1,1,1],[],[],[],[],[]])}

        it "shouldn't return winner if not vertical winner" do
          expect(board_vertical.winner).to be_nil
        end

        it "should return '0' as winner if vertical winner" do
          board_vertical.move([0,0])
          expect(board_vertical.winner).to eq(0)
        end

        it "should return '1' as winner if vertical winner" do
          board_vertical.move([3,0])
          board_vertical.move([1,1])
          expect(board_vertical.winner).to eq(1)
        end

      end

      context "forwardslash_winner" do

        let(:board_forwardslash) {Board.new([[0],[1,0],[0,1,0],[1,1,1],[],[],[]])}

        it "shouldn't return winner if not forwardslash winner" do
          expect(board_forwardslash.winner).to be_nil
        end

        it "should return 0 as the winner if forwardslash win" do
          board_forwardslash.move([3,0])
          expect(board_forwardslash.winner).to eq(0)
        end

      end

      context "backslash_winner" do

        let(:board_backslash) {Board.new([[],[],[],[1,0,1],[0,1,0],[1,0],[0]])}

        it "should not return winner if not backslash winner" do
          expect(board_backslash.winner).to be_nil
        end

        it "should return winner if there's a backslash win" do
          board_backslash.move([3,0])
          expect(board_backslash.winner).to eq(0)
        end

      end

    end
  end
end