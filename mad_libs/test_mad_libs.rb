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
		assert_equal ['name'], my_madlib.get_placeholders
		
		my_madlib = MadLib.new('My favourite food is ((favourite food)).')
		assert_equal ['favourite food'], my_madlib.get_placeholders
		
		my_madlib = MadLib.new('Big ((object))s on your toe make you say ((something you say))')
		assert_equal ['object', 'something you say'], my_madlib.get_placeholders
	end
	
	def test_can_list_multiple_placeholders_with_same_name
		my_madlib = MadLib.new('((a word)) hello ((a fruit)) hello ((a word))')
		assert_equal ['a word', 'a fruit', 'a word'], my_madlib.get_placeholders
	end
	
	def test_can_list_placeholder_broken_across_lines
		my_madlib = MadLib.new("Annie likes ((something made\nof chocolate))")
		assert_equal ['something made of chocolate'], my_madlib.get_placeholders
	end
	
	def test_can_set_placeholders
		my_madlib = MadLib.new('((name)) likes cheese')
		my_madlib.set_placeholder_text { |placeholder| 'Annie' }
		assert_equal ['Annie'], my_madlib.get_placeholder_text
		
		my_madlib = MadLib.new('My favourite food is ((favourite food)).')
		my_madlib.set_placeholder_text{ |placeholder| 'pizza' }
		assert_equal ['pizza'], my_madlib.get_placeholder_text
		
		my_madlib = MadLib.new('Big ((object))s on your toe make you say ((something you say))')
		placeholder_texts = ['elephant', 'ouch']
		block_call_count = 0
		my_madlib.set_placeholder_text do |placeholder|
			block_call_count = block_call_count + 1
			placeholder_texts[block_call_count - 1]
		end
		assert_equal ['elephant', 'ouch'], my_madlib.get_placeholder_text
	end
	
	def test_can_get_madlib_with_placeholders_substituted
		my_madlib = MadLib.new('((name)) likes cheese')
		my_madlib.set_placeholder_text { |placeholder| 'Annie' }
		assert_equal 'Annie likes cheese', my_madlib.get_substituted_madlib
		
		my_madlib = MadLib.new('My favourite food is ((favourite food)).')
		my_madlib.set_placeholder_text{ |placeholder| 'pizza' }
		assert_equal 'My favourite food is pizza.', my_madlib.get_substituted_madlib
		
		my_madlib = MadLib.new('Big ((object))s on your toe make you say ((something you say))')
		placeholder_texts = ['elephant', 'ouch']
		block_call_count = 0
		my_madlib.set_placeholder_text do |placeholder|
			block_call_count = block_call_count + 1
			placeholder_texts[block_call_count - 1]
		end
		assert_equal 'Big elephants on your toe make you say ouch', my_madlib.get_substituted_madlib
	end
	
	def test_placeholder_substitution_madlib_across_lines
		my_madlib = MadLib.new("Big ((object))s on your toe\nmake you say ((something you say))")
		placeholder_texts = ['elephant', 'ouch']
		block_call_count = 0
		my_madlib.set_placeholder_text do |placeholder|
			block_call_count = block_call_count + 1
			placeholder_texts[block_call_count - 1]
		end
		assert_equal "Big elephants on your toe\nmake you say ouch", my_madlib.get_substituted_madlib
	end
	
	def test_placeholder_split_across_lines
		my_madlib = MadLib.new("Annie likes ((something made\nof chocolate))")
		my_madlib.set_placeholder_text { |placeholder| 'gooey chocolate cake' }
		assert_equal 'Annie likes gooey chocolate cake', my_madlib.get_substituted_madlib
	end
	
	def test_placeholder_substitution_multiple_with_same_name
		my_madlib = MadLib.new('((vegetable)) is better than ((vegetable))')
		placeholder_texts = ['potato', 'brocolli']
		block_call_count = 0
		my_madlib.set_placeholder_text do |placeholder|
			block_call_count = block_call_count + 1
			placeholder_texts[block_call_count - 1]
		end
		assert_equal "potato is better than brocolli", my_madlib.get_substituted_madlib
	end
end

