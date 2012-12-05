# Class to read madlibs
class MadLib
	attr_reader :raw_madlib

	def initialize(raw_madlib)
		@raw_madlib = raw_madlib
		extract_placeholders
	end

	def list_placeholders
		@placeholders
	end
	
	private

	def extract_placeholders
		new_placeholder = Array.new
		raw_madlib.scan(/\(\((.*?)\)\)/) { |match| new_placeholder << match[0] }
		@placeholders = new_placeholder
	end

end

