require 'test/unit'
require_relative 'mad_libs_cmd'

class MadLibsCmdTests < Test::Unit::TestCase
	def test_can_read_madlib_from_file
		madlib_text = IO.readlines('./madlibs/simple.madlib')
		madlib_cmd = MadLibCmd.new('./madlibs/simple.madlib')
		assert_equal madlib_text[0], madlib_cmd.madlib.raw_madlib
	end
end
