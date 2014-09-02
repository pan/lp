require_relative 'doc'

module LonelyPlanet

  class Destinations
    attr_reader :all_destinations

    # +xml_file+ is the full path to destinations.xml
    def initialize(xml_file)
      @all_destinations = LonelyPlanet::Doc.load xml_file
    end

  end

  class Destination

    # +id+ is the value of a particular atlas_id
    # +all_destinations+ is an object created from class Destinations
    def initialize(id, all_destinations)
      @destination = all_destinations.css("[atlas_id='#{id}']")
    end

    # get the overview text for a particular destination
    def overview
      @destination.css('introduction overview').text
    end

    # get the name of the destination
    def name
      @destination.attr('title').to_s
    end

  end
end
