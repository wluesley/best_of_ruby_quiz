require 'test/unit'
require_relative 'mad_libs_cmd'

class MadLibsCmdTests < Test::Unit::TestCase
	def test_can_read_madlib_from_file
		madlib_text = IO.read('./madlibs/simple.madlib')
		madlib_cmd = MadLibCmd.new('./madlibs/simple.madlib')
		assert_equal madlib_text, madlib_cmd.madlib.raw_madlib
	end
	
	def test_can_read_multiline_madlib_from_file
		madlib_text = IO.read('./madlibs/Lunch_Hungers.madlib')
		madlib_cmd = MadLibCmd.new('./madlibs/Lunch_Hungers.madlib')
		assert_equal madlib_text, madlib_cmd.madlib.raw_madlib
	end
end
