require 'nokogiri'

module LonelyPlanet
  class Doc < Nokogiri::XML::Document
    # +xml_file+ : full path to an xml file
    def self.load(xml_file)
      parse File.read(xml_file)
    end
  end
end
