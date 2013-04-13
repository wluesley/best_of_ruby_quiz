require_relative 'mad_libs'

class MadLibCmd
	attr_accessor :madlib

	def initialize(filename)
		@madlib = MadLib.new(IO.readlines(filename)[0])
	end

end
