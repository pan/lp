require 'erb'
require 'fileutils'
require_relative 'utils'

module LonelyPlanet
  # this project root path
  PROJECT_PATH = File.expand_path("../../", __FILE__)

  # the web page generation using ERB template technology
  class Page

    # default +node_template+ "node.erb" is for all generated pages
    def initialize(node_template="node.erb")
      filename = File.join(PROJECT_PATH, "template", node_template)
      erb = ERB.new(File.read(filename))
      erb.def_method(Page, 'render(destination, hierarchy)', node_template)
    end

    # multi-threaded web pages maker
    class Maker
      
      # do the actual make action
      # +taxonomy_doc+ : the instance of LonelyPlanet::Taxonomy
      # +destinations_doc+ : the instance of LonelyPlanet::Destinations
      # +output_dir+ : output to this dir, specified on command line
      def self.make(taxonomy_doc, destinations_doc, output_dir)
        all_destinations_frag = destinations_doc.all_destinations
        page = LonelyPlanet::Page.new
        copy_css(output_dir)

        taxonomy_doc.continents.each { |continent|
          hierarchy = continent.show_tree
          threads = []
          continent.each { |node|
            threads << Thread.new {
              dest = LonelyPlanet::Destination.new node.id,all_destinations_frag
              if dest.exist?
                dest_file = File.join output_dir, str_strip(dest.name)
                printer = LonelyPlanet::Printer.new(dest_file)
                printer.print page.render(dest, hierarchy)
              end
            }
          }
          threads.each { |t| t.join }
        }
      end

      # copy the updated css file to the output directory, it also creates
      # necessary dir +to_dir+
      def self.copy_css(to_dir)
        css_file = File.join PROJECT_PATH, "template", "static", "all.css"
        target_dir = File.join(to_dir, "static")
        FileUtils.mkdir_p(target_dir)
        FileUtils.cp(css_file, target_dir)
      end

      include LonelyPlanet::Utils
      extend LonelyPlanet::Utils
    end
  end

  # write file to target directory where the file with the same file name
  # will be overwritten
  class Printer

    # +filename+ should be a full path to a file without its extention name
    # such as /write_to/somewhere/destination name, the final destination name
    # will be converted with normalize().
    def initialize(filename)
      base = File.basename filename
      dir = File.dirname filename
      print_to = File.join dir, normalize(base)
      @file = File.new print_to, 'w+'
    end

    # write +content+ to the file
    def print(content)
      @file.print content
    end

    include LonelyPlanet::Utils
  end
end
