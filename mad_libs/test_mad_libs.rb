require 'test/unit'
require_relative 'mad_libs'

class MadLibsTests < Test::Unit::TestCase
	def test_can_set_and_read_raw_madlib
		# ensure we can load and view the raw madlib string
		raw_madlib = '((name)) likes cheese'
		my_madlib = MadLib.new(raw_madlib)
		assert_equal raw_madlib, my_madlib.raw_madlib
	end

	def test_can_list_placeholders
		my_madlib = MadLib.new('((name)) likes cheese')
		assert_equal ['name'], my_madlib.list_placeholders
		
		my_madlib = MadLib.new('My favourite food is ((favourite food)).')
		assert_equal ['favourite food'], my_madlib.list_placeholders
		
		my_madlib = MadLib.new('Big ((object))s on your toe make you say ((something you say))')
		assert_equal ['object', 'something you say'], my_madlib.list_placeholders
	end

	def test_can_set_placeholders
		my_madlib = MadLib.new('((name)) likes cheese')
		my_madlib.set_placeholder_text('name', 'Annie')
		assert_equal 'Annie', my_madlib.get_placeholder_text('name')
		
		my_madlib = MadLib.new('My favourite food is ((favourite food)).')
		my_madlib.set_placeholder_text('favourite food', 'pizza')
		assert_equal 'pizza', my_madlib.get_placeholder_text('favourite food')
		
		my_madlib = MadLib.new('Big ((object))s on your toe make you say ((something you say))')
		my_madlib.set_placeholder_text('object', 'elephant')
		my_madlib.set_placeholder_text('something you say', 'ouch')
		assert_equal 'elephant', my_madlib.get_placeholder_text('object')
		assert_equal 'ouch', my_madlib.get_placeholder_text('something you say')
	end

	def test_setting_wrong_placeholder_throws_exception
		my_madlib = MadLib.new('((name)) likes cheese')
		assert_raises(KeyError){ my_madlib.set_placeholder_text('bob', 'bob') }
	end

	def test_getting_wrong_placeholder_throws_exception
		my_madlib = MadLib.new('((name)) likes cheese')
		assert_raises(KeyError){ my_madlib.get_placeholder_text('bob') }
	end
end

