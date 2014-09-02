require_relative 'common'
require 'options'

module LonelyPlanet
  class TestOptions < MiniTest::Test
    include LonelyPlanet::Test

    def test_parse
      args = %w(processor.rb -t taxonomy.xml -d destinations.xml -o output)
      options = LonelyPlanet::Options.parse args
      assert options[:taxonomy]
      assert options[:destination]
      assert options[:output]
    end

    def test_exit_when_required_option_not_provided
      args = %w(processor.rb -d destinations.xml)
      assert_raises(SystemExit) do
        capture_io do 
          LonelyPlanet::Options.parse args
        end
      end
    end
  end
end
