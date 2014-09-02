require 'optparse'

module LonelyPlanet
  class Options

    # command line arguments +args+ parser, it will make sure the required
    # options are provided. Otherwise, it shows the help.
    def self.parse(args)
      options = {}
      optparser = OptionParser.new do |opts|
        opts.banner = "Usage: #{opts.program_name} <options>"

        opts.on("-t", "--taxonomy taxonomy.xml", 
                "Full path to the taxonomy file") do |opt_taxonomy|
          options[:taxonomy] = opt_taxonomy
        end

        opts.on("-d", "--destination destinations.xml",
                "Full path to the destinations file") do |opt_destination|
          options[:destination] = opt_destination
        end

        opts.on("-o", "--output directory",
                "Output to this directory") do |opt_output|
          options[:output] = opt_output
        end

        opts.on_tail("-h", "--help", "Show this help message") do
          puts opts
          exit
        end

      end

      optparser.parse!(args)
      abort optparser.help() if options.empty?
      abort "Option --taxonomy is required"    unless options[:taxonomy]
      abort "Option --destination is required" unless options[:destination]
      abort "Option --output is required"      unless options[:output]
      options
    end

  end
end
