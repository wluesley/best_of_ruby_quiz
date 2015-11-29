# Represents a horizontal row
class HorizontalDigitRow
	def initialize(element_on, size=1)
		raise 'Size must be non-negative, non-zero' if size <= 0
		@element_on = element_on
		@size = size
	end

	def to_s
		output = ' '

		if @element_on then
			output << '-' * @size
		else
			output << ' ' * @size
		end

		output << ' '
	end
end

class VerticalDigitRow
	def initialize(left_element_on, right_element_on, size=1)
		raise 'Size must be non-negative, non-zero' if size <= 0
		@left_element_on = left_element_on
		@right_element_on = right_element_on
		@size = size
	end

	def to_s
		output = String.new
		output << (@left_element_on ? '|' : ' ')
		output << ' ' * @size
		output << (@right_element_on ? '|' : ' ')
		return output
	end
end


# Class to print a single LCD digit
class Digit
	def initialize(active_elements, size=1)
		raise 'Incorrect initialization array size' if active_elements.length != 7
		raise 'Size must be non-negative, non-zero' if size <= 0

		@rows = Array.new
		@rows << HorizontalDigitRow.new(active_elements[0], size)
		add_vertical_rows(active_elements[1], active_elements[2], size)
		@rows << HorizontalDigitRow.new(active_elements[3], size)
		add_vertical_rows(active_elements[4], active_elements[5], size)
		@rows << HorizontalDigitRow.new(active_elements[6], size)
	end

	def line_to_s(line)
		@rows[line].to_s
	end

private
	def add_vertical_rows(left_element_on, right_element_on, size)
		verticalRow = VerticalDigitRow.new(left_element_on, right_element_on, size)
		size.times { @rows << verticalRow }
	end
end

class NumberDigit
	def initialize(number)
		case
		when number == 0
			@digit = Digit.new([true, true, true, false, true, true, true])
		when number == 1
			@digit = Digit.new([false, false, true, false, false, true, false])
		when number == 2
			@digit = Digit.new([true, false, true, true, true, false, true])
		when number == 3
			@digit = Digit.new([true, false, true, true, false, true, true])
		when number == 4
			@digit = Digit.new([false, true, true, true, false, true, false])
		when number == 5
			@digit = Digit.new([true, true, false, true, false, true, true])
		when number == 6
			@digit = Digit.new([true, true, false, true, true, true, true])
		when number == 7
			@digit = Digit.new([true, false, true, false, false, true, false])
		when number == 8
			@digit = Digit.new([true, true, true, true, true, true, true])
		when number == 9
			@digit = Digit.new([true, true, true, true, false, true, true])
		# Anything that isn't a single digit should raise an error.
		else raise 'Bad initializer. Can only initialize with single digit non-negative number'
		end
	end

	# Just pass all calls through to digit
	def method_missing(name, *args, &block)
		@digit.send(name, *args, &block)
	end
end
