require 'minitest/autorun'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

module LonelyPlanet
  module Test
    PROJECT_PATH = File.expand_path '../../', __FILE__
    TEST_DATA_DIR = File.join PROJECT_PATH, "test", "data" 
    TAXONOMY_FILE = File.join TEST_DATA_DIR, "taxonomy.xml" 
    DESTINATIONS_FILE = File.join TEST_DATA_DIR, "destinations.xml" 
  end
end
