require_relative 'common'
require 'page'
require 'taxonomy'
require 'destination'

module LonelyPlanet
  class TestPage < MiniTest::Test
    include LonelyPlanet::Test

    def test_new
      page = LonelyPlanet::Page.new
      assert page.respond_to?("render")
    end

    def test_make_and_copy_css
      taxonomy_doc = LonelyPlanet::Taxonomy.new TAXONOMY_FILE
      destinations_doc = LonelyPlanet::Destinations.new DESTINATIONS_FILE
      output = File.join TEST_DATA_DIR, "output"
      LonelyPlanet::Page::Maker.make taxonomy_doc, destinations_doc, output
      assert File.exist?(File.join(output, "Africa.html"))
      assert File.exist?(File.join(output, "static", "all.css"))
      FileUtils.rm_r(output)
    end

    def test_printer_print
      printer = LonelyPlanet::Printer.new File.join(TEST_DATA_DIR, "write test")
      printer.print("hi printer")
      expected_file = File.join TEST_DATA_DIR, "write_test.html"
      assert printer.is_a?(LonelyPlanet::Printer)
      assert File.exist?(expected_file)
      File.unlink expected_file
    end

  end
end
