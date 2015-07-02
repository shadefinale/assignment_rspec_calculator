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

      it "doesn't improperly divide numbers" do
        expect(calculator.divide(4,2)).not_to eq(7)
      end

      it "properly divides positive numbers" do
        expect(calculator.divide(4,2)).to eq(2)
      end

      it "properly divides floats" do
        expect(calculator.divide(5.0,2.5)).to eq(2.0)
      end

      it "properly divides negative numbers" do
        expect(calculator.divide(-2,2)).to eq(-1)
        expect(calculator.divide(-12,-3)).to eq(4)
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

    describe "#pow" do

      it "shouldn't improperly raise powers" do
        expect(calculator.pow(2,4)).not_to eq(8)
      end

      it "should properly raise integer powers" do
        expect(calculator.pow(2,3)).to eq(8)
        expect(calculator.pow(2,4)).to eq(16)
        expect(calculator.pow(1, 1000)).to eq(1)
        expect(calculator.pow(3,4)).to eq (81)
      end

      it "should properly raise negative powers" do
        expect(calculator.pow(4,-1)).to eq(0.25)
        expect(calculator.pow(-4, -1)).to eq(-0.25)
      end

      it "should raise fractional powers" do
        expect(calculator.pow(4, 0.5)).to eq(2)
        expect(calculator.pow(4, -0.5)).to eq(0.5)
      end

    end

    describe "#sqrt" do

      it "should not return incorrect square root" do
        expect(calculator.sqrt(4)).not_to eq(3)
      end

      it "should return basic square root" do
        expect(calculator.sqrt(4)).to eq(2)
      end

      it "should not raise error for positive input" do
        expect{ calculator.sqrt(4)}.not_to raise_error
      end

      it "should raise ArgumentError for negative input" do
        expect{ calculator.sqrt(-4)}.to raise_error(ArgumentError)
      end

      it "should return integer for round roots" do
        expect(calculator.sqrt(4)).to be_a(Integer)
      end

      it "should return 2 place float for non-round roots" do
        val = calculator.sqrt(2)
        expect(val).to be_a(Float)
        expect(val).to be_within(0.001).of(1.41)
      end

    end

    describe "#memory=" do

      it "should store a value if passed a value in argument" do
        calculator.memory=(5)
        expect(calculator.instance_variable_get(:@memory)).not_to be_nil
      end

      it "should return stored value when called" do
        calculator.memory=(5)
        expect(calculator.memory).to eq(5)
      end

      it "should not have stored value after called" do
        calculator.memory=(5)
        expect(calculator.memory).to eq(5)
        expect(calculator.memory).to be_nil
      end

      it "should overwrite value if passed new value" do
        calculator.memory=(5)
        expect(calculator.instance_variable_get(:@memory)).to eq(5)
        calculator.memory=(6)
        expect(calculator.instance_variable_get(:@memory)).not_to eq(5)
        expect(calculator.instance_variable_get(:@memory)).to eq(6)
      end
    end

    describe "#memory" do
      it "should return nil if memory is empty" do
        expect(calculator.memory).to be_nil
      end
    end



  end

  context "strings" do

  end

end