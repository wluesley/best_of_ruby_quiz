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
		@named_placeholders = Hash.new
		@placeholders.each do |placeholder|
			# A placeholder can be one of three types:
			# * basic placeholder: this is a placeholder where we simply swap the placeholder for a value from the user ((a verb))
			# * named placeholder: this is a placeholder that also has a name that can be reused ((gem:a gemstone))
			# * reuse of named placeholder: these look the same as a basic placeholder, but have a description the same as a named placeholders name.
			
			# Determine whether this is a named placeholder
			named_placeholder_pattern = /(.*):(.*)/
			matches = named_placeholder_pattern.match(placeholder)
			if !matches.nil? 
				# This is a named placeholder. matches[1] will be the placeholder's name, matches[2] will be the placeholder's description
				
				# Get the substitution text
				text = yield matches[2].gsub(/\n/, ' ')
				# Store this as the substitute for this instance of the named placeholder
				@placeholder_text << text
				# Store the name and substitution for future users of the named placeholder
				@named_placeholders[matches[1]] = text
			else
				# This is not a named placeholder. It could either be a name of a previously defined named placeholder, 
				# or a new basic placeholder.
				if @named_placeholders.has_key?(placeholder)
					# This is a name of a named placeholder
					@placeholder_text << @named_placeholders[placeholder]
				else
					# This is a basic placeholder
					text = yield placeholder.gsub(/\n/, ' ')
					@placeholder_text << text	
				end
			end
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


