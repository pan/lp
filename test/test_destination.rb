require_relative 'common'
require 'destination'

module LonelyPlanet
  class TestDestination < MiniTest::Test
    include LonelyPlanet::Test

    def setup
      @destinations_doc = LonelyPlanet::Destinations.new DESTINATIONS_FILE
      @destination = LonelyPlanet::Destination.new( 
        '355612', @destinations_doc.all_destinations)
    end

    def test_destinations_new
      assert_equal LonelyPlanet::Destinations, @destinations_doc.class
      assert @destinations_doc.all_destinations.is_a? LonelyPlanet::Doc
    end

    def test_destination_name
      assert_equal "Cape Town", @destination.name
    end

    def test_destination_overview
      assert @destination.overview.include?('Good-looking')
    end
  end
end
