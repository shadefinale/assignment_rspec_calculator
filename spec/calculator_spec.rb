require "calculator"

describe Calculator do

  context "numbers" do

    let(:calculator) { Calculator.new }

    describe "#add" do

      it "should not add 1 and 1 and get 3" do
        expect(calculator.add(1,1)).not_to eq(3)
      end

      it "should add 2 and 2 and get 4" do
        expect(calculator.add(2,2)).to eq(4)
      end

      it "adds negative numbers" do
        expect(calculator.add(-2,-3)).to eq(-5)
      end

      it "adds float numbers" do
        expect(calculator.add(3.1,2.6)).to eq(5.7)
      end

      it "adds negative and float numbers" do
        expect(calculator.add(1223,-2.27)).to eq(1220.73)
      end

    end

    describe "#subtract" do

      it "should not subtract 5 from 10 and get 4" do
        expect(calculator.subtract(10,5)).not_to eq(4)
      end

      it "should subtract 5 from 10 and get 5" do
        expect(calculator.subtract(10,5)).to eq(5)
      end

      it "should subtract negative numbers" do
        expect(calculator.subtract(10,-5)).to eq(15)
        expect(calculator.subtract(-10,5)).to eq(-15)
      end

      it "should subtract float numbers" do
        expect(calculator.subtract(2.3,1.1)).to be_within(0.01).of(1.2)
        expect(calculator.subtract(3.0,3.1)).to be_within(0.01).of(-0.1)
      end

    end

    describe "#multiply" do

      it "should correctly multiply positive numbers" do
        expect(calculator.multiply(1,2)).to eq(2)
        expect(calculator.multiply(0,10)).to eq(0)
      end

      it "should correctly multiply negative numbers" do
        expect(calculator.multiply(2,-2)).to eq(-4)
        expect(calculator.multiply(-2,-2)).to eq(4)
      end

      it "should multiply float numbers" do
        expect(calculator.multiply(2.5,-2)).to eq(-5)
      end

      it "should not incorrectly multiply numbers" do
        expect(calculator.multiply(1,2)).not_to eq(1)
        expect(calculator.multiply(0,10)).not_to eq(1)
        expect(calculator.multiply(2,-2)).not_to eq(4)
        expect(calculator.multiply(-2,-2)).not_to eq(-4)
        expect(calculator.multiply(2.5,-2)).not_to eq(5)
      end

    end

    describe "#divide" do

      it "properly divides positive numbers" do
        expect(calculator.divide(4,2)).to eq(2)
      end

      it "should raise an argument error if divide by 0" do
        expect{calculator.divide(2,0)}.to raise_error(ArgumentError)
      end

      it "should not raise an error if dividend is 0" do
        expect{calculator.divide(0,3)}.not_to raise_error
      end

      it "should return integer if no remainder" do
        expect(calculator.divide(4,2)).to be_a(Integer)
      end

      it "should return float if there's a remainder" do
        expect(calculator.divide(5,2)).to be_a(Float)
      end

    end

  end

  context "strings" do

  end

end