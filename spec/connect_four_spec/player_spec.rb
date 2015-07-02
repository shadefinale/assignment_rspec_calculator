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

  let(:ai) {AI.new([],0)}

  describe "#initialize" do

    it "should inherit from player class" do

      expect(ai).to be_a(Player)

    end

  end

end