#!/usr/bin/env ruby

require_relative 'lib/loader'

options = LonelyPlanet::Options.parse(ARGV)

taxonomy_doc = LonelyPlanet::Taxonomy.new options[:taxonomy]
destinations_doc = LonelyPlanet::Destinations.new options[:destination]
output_dir = options[:output]

LonelyPlanet::Page::Maker.make(taxonomy_doc, destinations_doc, output_dir)
