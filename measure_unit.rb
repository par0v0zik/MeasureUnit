module UnitConversion
  # Base units:
  # Length - meter
  # Weight - gramm
  CONVERSION_RATES = {
      :meters => 1, :feets => 3.2808399, :inches => 39.3700787, :centimeters => 100,
      :pounds => 0.00220462262, :gramms => 1, :kilograms => 0.001, :ounces => 0.0352739619,
  }

  # To check type mismatch
  UNIT_TYPES = {
      :meters => :length, :feets => :length, :inches => :length, :centimeters => :length,
      :pounds => :weight, :gramms => :weight, :kilograms => :weight, :ounces => :weight
  }

  module ConvertionMethods

    UNIT_TYPES.keys.each do |type|
      # add method for convert numbers into measure units
      define_method type do
        # Convert to MeasureUnit with base type
        MeasureUnit.new(self / CONVERSION_RATES[type.to_sym], type.to_sym)
      end
    end

    alias_method :meter, :meters
    alias_method :feet, :feets
    alias_method :inch, :inches
    alias_method :centimeter, :centimeters
    alias_method :pound, :pounds
    alias_method :gramm, :gramms
    alias_method :kilogram, :kilograms
    alias_method :ounce, :ounces

  end

end

class MeasureUnit

  include UnitConversion

  attr_reader :value, :type

  def initialize(value, type)
    @value = value
    @type = type
  end

  def in(new_type)
    # check if old and new unit's types belong to the same group (length, weight)
    if UNIT_TYPES[@type] == UNIT_TYPES[new_type]
      @value * CONVERSION_RATES[new_type]
    else
      raise TypeMismatch
    end
  end

  TypeMismatch = Class.new(StandardError) 

end

class Numeric

  include UnitConversion
  include UnitConversion::ConvertionMethods

end