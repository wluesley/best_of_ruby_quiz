require_relative 'mad_libs'
require_relative 'ui'
require 'getoptlong'

class MadLibCmd
	attr_accessor :madlib

	def initialize(filename)
		@madlib = MadLib.new(IO.read(filename))
		@console = ConsoleUi.new
	end
  
  def get_placeholder_text
    # iterate over each of the placeholders, getting a value from the user
	@madlib.set_placeholder_text { |name| @console.ask("Please enter #{name}") }
  end
  
  def get_madlib
    @madlib.get_substituted_madlib
  end

end

if $0 == __FILE__
  # setup the options parser
  parser = GetoptLong.new(
    ['-h', '--help', GetoptLong::NO_ARGUMENT],
    ['-f', '--file', GetoptLong::REQUIRED_ARGUMENT])
  
  filename = nil
    
  
  begin
  	parser.each do | opt, arg |
  		puts opt + ' => ' + arg
  	  
  		case opt
  			when '-h'
  				puts 'Usage: madlibs -f <madlibs_file>'
  				break
  			when '-f'
  				filename = arg
  				break
  		end
  	end
  rescue => err
  	puts err
  end
  
  madlibcmd = MadLibCmd.new(filename)
  madlibcmd.get_placeholder_text
  puts madlibcmd.get_madlib
end

