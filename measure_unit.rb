class MeasureUnit

	attr_reader :value, :type

	CONVERSION_RATES = {
			:meters => {:meters => 1, :feets => 3.2808399, :inches => 39.3700787, :centimeters => 100},
			:feets => {:meters => 0.3048, :feets => 1, :inches => 12, :centimeters => 0.032808399},
			:inches => {:meters => 0.0254, :feets => 0.0833333, :inches => 1, :centimeters => 2.54},
			:centimeters => {:meters => 0.01, :feets => 0.032808399, :inches => 0.393700787, :centimeters => 1},
			:pounds => {:pounds => 1, :gramms => 453.59237, :kilograms => 0.45359237, :ounces => 16},
			:gramms => {:pounds => 0.00220462262, :gramms => 1, :kilograms => 0.001, :ounces => 0.0352739619},
			:kilograms => {:pounds => 2.20462262, :gramms => 1000, :kilograms => 1, :ounces => 35.2739619},
			:ounces => {:pounds => 0.0625, :gramms => 28.3495231, :kilograms => 0.0283495231, :ounces => 1}

			 }

	UNIT_TYPES = {
			:meters => :length, :feets => :length, :inches => :length, :centimeters => :length,
			:pounds => :weight, :gramms => :weight, :kilograms => :weight, :ounce => :weight
		}

	def initialize(value, type)
		@value = value
		@type = type	
	end

	def in(new_type)
		# check if old and new unit's types belong to the same group (length, weight)
		if UNIT_TYPES[@type] == UNIT_TYPES[new_type]
			@value*CONVERSION_RATES[@type][new_type]
		else
			raise TypeMismatch
		end
	end

	class TypeMismatch < StandardError
	end

end

class Numeric
	["meters", "feets", "inches", "centimeters", "pounds", "gramms", "kilograms", "ounces"].each do |type|
		# add method for convert numbers into measure units
		define_method type do
			MeasureUnit.new(self, type.to_sym)
		end
		#alias_method type.singularize, type
	end
end