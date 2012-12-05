# Class to read madlibs

class MadLib
	attr_reader :raw_madlib

	def initialize(raw_madlib)
		@raw_madlib = raw_madlib
		extract_placeholders
	end

	def list_placeholders
		@placeholders.keys
	end

	def set_placeholder_text(placeholder, text)
		if @placeholders.has_key?(placeholder) 
			@placeholders[placeholder] = text
		else
			raise KeyError
		end
	end		

	def get_placeholder_text(placeholder)
		@placeholders.fetch(placeholder)
	end
	
	def get_substituted_madlib
		substituted_madlib = @raw_madlib 
		# iterate over each placeholder, replacing with its text
		@placeholders.each do |name, text|
			substituted_madlib.sub!(/\(\(#{name}\)\)/, text)
		end
		substituted_madlib	
	end
	
	private

	def extract_placeholders
		new_placeholders= Hash.new
		raw_madlib.scan(/\(\((.*?)\)\)/) { |match| new_placeholders.store(match[0], nil) }
		@placeholders = new_placeholders
	end
end


