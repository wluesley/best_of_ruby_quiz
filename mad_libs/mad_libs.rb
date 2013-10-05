# Class to read madlibs


class MadLib
	attr_reader :raw_madlib

	def initialize(raw_madlib)
		@raw_madlib = raw_madlib
		extract_placeholders
	end

	
	def set_placeholder_text
		# iterate over all the placeholders, populating the text via the passed in block
		@placeholder_text = Array.new
		@placeholders.each do |placeholder|
			text= yield placeholder.gsub(/\n/, ' ')
			@placeholder_text << text
		end
	end		
	
	def get_placeholders
		@placeholders.map { |placeholder| placeholder.gsub(/\n/, ' ') }
	end
	
	def get_placeholder_text
		@placeholder_text
	end
	
	def get_substituted_madlib
		substituted_madlib = String.new(@raw_madlib)
		# iterate over each placeholder, replacing with its text
		@placeholders.each_with_index do |name, index|
			substituted_madlib.sub!(/\(\(#{name}\)\)/, @placeholder_text[index])
		end
		substituted_madlib	
	end
	
	private

	def extract_placeholders
		new_placeholders= Array.new
		raw_madlib.scan(/\(\((.*?)\)\)/m) { |match| new_placeholders << match[0] }
		@placeholders = new_placeholders
	end
end


