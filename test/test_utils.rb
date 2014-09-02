require_relative 'common'
require 'utils'

module LonelyPlanet
  class TestUtils < MiniTest::Test
    include LonelyPlanet::Utils

    def test_str_strip
      str = str_strip "Port Sudan "
      assert_equal "Port_Sudan", str
    end

    def test_normalize
      str = normalize "Port Sudan "
      assert_equal "Port_Sudan.html", str
    end
  end
end
