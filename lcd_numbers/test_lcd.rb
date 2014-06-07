require 'test/unit'
require_relative 'lcd'

class LcdTests < Test::Unit::TestCase
	def test_horizontal_row_prints
		row = HorizontalDigitRow.new(true)
		assert_equal(' - ', row.to_s)
		row = HorizontalDigitRow.new(false)
		assert_equal('   ', row.to_s)
	end

	def test_vertical_row_prints
		row = VerticalDigitRow.new(true, true)
		assert_equal('| |', row.to_s)
		row = VerticalDigitRow.new(false, true)
		assert_equal('  |', row.to_s)
		row = VerticalDigitRow.new(true, false)
		assert_equal('|  ', row.to_s)
		row = VerticalDigitRow.new(false, false)
		assert_equal('   ', row.to_s)
	end

	def test_digit_will_all_elements_on
		digit = Digit.new([true,true,true,true,true,true,true])
		# check each line is printed correctly
		assert_equal(' - ', digit.line_to_s(0))
		assert_equal('| |', digit.line_to_s(1))
		assert_equal(' - ', digit.line_to_s(2))
		assert_equal('| |', digit.line_to_s(3))
		assert_equal(' - ', digit.line_to_s(4))
	end

	def test_digit_with_no_elements_on
		digit = Digit.new([false, false, false, false, false, false, false])
		for line in 0..4 do
			assert_equal('   ', digit.line_to_s(line))
		end
	end

	def test_digit_individual_elements
		digit = Digit.new([true, false, false, false, false, false, false])
		assert_equal(' - ', digit.line_to_s(0))
		assert_equal('   ', digit.line_to_s(1))
		assert_equal('   ', digit.line_to_s(2))
		assert_equal('   ', digit.line_to_s(3))
		assert_equal('   ', digit.line_to_s(4))

		digit = Digit.new([false, true, false, false, false, false, false])
		assert_equal('   ', digit.line_to_s(0))
		assert_equal('|  ', digit.line_to_s(1))
		assert_equal('   ', digit.line_to_s(2))
		assert_equal('   ', digit.line_to_s(3))
		assert_equal('   ', digit.line_to_s(4))

		digit = Digit.new([false, false, true, false, false, false, false])
		assert_equal('   ', digit.line_to_s(0))
		assert_equal('  |', digit.line_to_s(1))
		assert_equal('   ', digit.line_to_s(2))
		assert_equal('   ', digit.line_to_s(3))
		assert_equal('   ', digit.line_to_s(4))

		digit = Digit.new([false, false, false, true, false, false, false])
		assert_equal('   ', digit.line_to_s(0))
		assert_equal('   ', digit.line_to_s(1))
		assert_equal(' - ', digit.line_to_s(2))
		assert_equal('   ', digit.line_to_s(3))
		assert_equal('   ', digit.line_to_s(4))

		digit = Digit.new([false, false, false, false, true, false, false])
		assert_equal('   ', digit.line_to_s(0))
		assert_equal('   ', digit.line_to_s(1))
		assert_equal('   ', digit.line_to_s(2))
		assert_equal('|  ', digit.line_to_s(3))
		assert_equal('   ', digit.line_to_s(4))

		digit = Digit.new([false, false, false, false, false, true, false])
		assert_equal('   ', digit.line_to_s(0))
		assert_equal('   ', digit.line_to_s(1))
		assert_equal('   ', digit.line_to_s(2))
		assert_equal('  |', digit.line_to_s(3))
		assert_equal('   ', digit.line_to_s(4))

		digit = Digit.new([false, false, false, false, false, false, true])
		assert_equal('   ', digit.line_to_s(0))
		assert_equal('   ', digit.line_to_s(1))
		assert_equal('   ', digit.line_to_s(2))
		assert_equal('   ', digit.line_to_s(3))
		assert_equal(' - ', digit.line_to_s(4))
	end

	def test_incorrectly_sized_initializer_array_throws
		# No elements
		assert_raise(RuntimeError) { Digit.new([]) }
		# Too few elements
		assert_raise(RuntimeError) { Digit.new([0,0,0,0,0,0]) }
		# Too many elements
		assert_raise(RuntimeError) { Digit.new([0,0,0,0,0,0,0,0]) }
	end

	def test_numbers_work
		number = NumberDigit.new(0)
		digit = Digit.new([true, true, true, false, true, true, true])
		compare_number_to_digit(digit, number)
		
		number = NumberDigit.new(1)
		digit = Digit.new([false, false, true, false, false, true, false])
		compare_number_to_digit(digit, number)
		
		number = NumberDigit.new(2)
		digit = Digit.new([true, false, true, true, true, false, true])
		compare_number_to_digit(digit, number)
		
		number = NumberDigit.new(3)
		digit = Digit.new([true, false, true, true, false, true, true])
		compare_number_to_digit(digit, number)
		
		number = NumberDigit.new(4)
		digit = Digit.new([false, true, true, true, false, true, false])
		compare_number_to_digit(digit, number)
		
		number = NumberDigit.new(5)
		digit = Digit.new([true, true, false, true, false, true, true])
		compare_number_to_digit(digit, number)
		
		number = NumberDigit.new(6)
		digit = Digit.new([true, true, false, true, true, true, true])
		compare_number_to_digit(digit, number)
		
		number = NumberDigit.new(7)
		digit = Digit.new([true, false, true, false, false, true, false])
		compare_number_to_digit(digit, number)
		
		number = NumberDigit.new(8)
		digit = Digit.new([true, true, true, true, true, true, true])
		compare_number_to_digit(digit, number)
		
		number = NumberDigit.new(9)
		digit = Digit.new([true, true, true, true, false, true, true])
		compare_number_to_digit(digit, number)
	end

	def test_negative_numbers_raise
		assert_raise(RuntimeError) { NumberDigit.new(-2) }
	end

	def test_numbers_greater_than_nine_raise
		assert_raise(RuntimeError) { NumberDigit.new(10) }
	end

	def test_non_numbers_raise
		assert_raise(RuntimeError) { NumberDigit.new('abc') }
	end

	private

	def compare_number_to_digit(number, digit)
		for line in 0..4 do
			assert_equal(digit.line_to_s(line), number.line_to_s(line))
		end	
	end

end
