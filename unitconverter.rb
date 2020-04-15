#we want a UnitConverter.new.convert(2, :cup, "liter") => 0.473
#we want a UnitConverter.new.convert(2, :cup, "gram") => to give us a dimensional mismatch error

require "rspec/autorun"

DimensionalMismatchError = Class.new(StandardError)
# Quantity = Struct.new(:amount, :unit)
class Quantity 
attr_accessor :amount, :unit
    def initialize(amount, unit)
        @amount = amount
        @unit = unit
    end

end

class UnitConverter
    def initialize( base_quantity, target_unit)
        @base_quantity = base_quantity
        @target_unit = target_unit
    end

    def convert
        Quantity.new(@base_quantity.amount * conversion_factor(from: @base_quantity.unit, to: @target_unit), @target_unit)
    end

private 

CONVERSION_FACTORS = {
    cup: {
        liter: 0.236588
    }
}
    
    def conversion_factor(from:, to:)
        CONVERSION_FACTORS[from][to] ||
        raise(DimensionalMismatchError, "can't convert from different dimensions")
    end 

end

describe UnitConverter do 
    describe "#convert" do    
           it "translates between objects of the same dimension" do 
            cups = Quantity.new(2, :cup)
            converter = UnitConverter.new(cups, :liter)
            
            result = converter.convert
            expect(result.amount).to be_within(0.001).of(0.473)
            expect(result.unit).to eq(:liter)
           end

           it "raises an error if the two quantities have different dimensions" do 
            cups = Quantity.new(2, :cup)
            converter = UnitConverter.new(cups, :gram)

            expect { converter.convert }.to raise_error(DimensionalMismatchError)
           end

    end 
    
end