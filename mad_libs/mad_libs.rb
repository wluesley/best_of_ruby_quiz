# Class to read madlibs


class MadLib
	attr_reader :raw_madlib
	attr_reader :placeholders

	def initialize(raw_madlib)
		@raw_madlib = raw_madlib
		extract_placeholders
	end

	
	def set_placeholder_text
		# iterate over all the placeholders, populating the text via the passed in block
		@placeholder_text = Array.new
		placeholders.each do |placeholder|
			text= yield placeholder
			@placeholder_text << text
		end
	end		

	def get_placeholder_text
		@placeholder_text
	end
	
	def get_substituted_madlib
		substituted_madlib = @raw_madlib 
		# iterate over each placeholder, replacing with its text
		@placeholders.each_with_index do |name, index|
			substituted_madlib.sub!(/\(\(#{name}\)\)/, @placeholder_text[index])
		end
		substituted_madlib	
	end
	
	private

	def extract_placeholders
		new_placeholders= Array.new
		raw_madlib.scan(/\(\((.*?)\)\)/) { |match| new_placeholders << match[0] }
		@placeholders = new_placeholders
	end
end


