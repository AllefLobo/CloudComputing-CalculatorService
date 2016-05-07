class Operation < ActiveRecord::Base

def initialize (type, first_value, second_value)
		@type = type
		@first_value = first_value
		@second_value = second_value
	end

	def calculate
		result = nil
		case @type
			when "sum"
				result = sum
			when "multiply"
				result = multiply
			when "subtract"
				result = subtract
			when "divide"
				result = divide
			else
				puts "Type Error"
			end
		result
	end

	private
	def sum
		@first_value + @second_value
	end

	private
	def multiply
		@first_value * @second_value
	end

	private
	def subtract
		@first_value - @second_value
	end

	private
	def divide
		@first_value / @second_value
	end


end
