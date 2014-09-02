require_relative 'common'
require 'doc'

module LonelyPlanet
  class TestDoc < MiniTest::Test
    include LonelyPlanet::Test

    def test_load
      @doc = LonelyPlanet::Doc.load TAXONOMY_FILE
      assert_equal LonelyPlanet::Doc, @doc.class
      assert @doc.respond_to? 'css'
    end

  end
end
                 
