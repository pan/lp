require_relative 'common'
require 'taxonomy'

module LonelyPlanet
  class TestTaxonomy < MiniTest::Test
    include LonelyPlanet::Test

    def setup
      @taxonomy_doc = LonelyPlanet::Taxonomy.new TAXONOMY_FILE
    end

    def test_build_tree
       assert_equal 1, @taxonomy_doc.continents.count
    end

    def test_set_continents
      assert_equal "Africa", @taxonomy_doc.continents.first.name
    end

  end
end
                 
