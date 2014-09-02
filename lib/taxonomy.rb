require_relative 'doc'
require_relative 'node'

module LonelyPlanet

  # build taxonomy trees. This supposes that there may have more than one 
  # continent in the file taxonomy.xml. So this class is designed to work with
  # one continent or more. And I suppose it has this format,
  #   ...
  #     <taxonomy>
  #       <node ... 
  #          and its sub nodes for one continent
  #       <node ...
  #          sub nodes for another continent
  # and it can be changed easily if it doesn't look like this.
  class Taxonomy
    attr_reader :continents

    # +xml_file+ : full path to taxonomy.xml
    def initialize(xml_file)
      doc_taxonomies = LonelyPlanet::Doc.load xml_file
      taxonomies_fragement = doc_taxonomies.css 'taxonomy > node'
      @continents = []
      set_continents(taxonomies_fragement)
    end

    private
    # set up all the continents trees from the top(continent) level of nodes
    # +taxonomies_fragement+ : the taxonomies fragement doc
    def set_continents(taxonomies_fragement)
      taxonomies_fragement.each { |taxonomy|
        continent = build_tree(taxonomy)
        @continents << continent
      }
    end

    # build tree from +nodes_fragement+ doc
    def build_tree(nodes_fragement)
      nodes_element = LonelyPlanet::Node.new nodes_fragement
      node = LonelyPlanet::TreeNode.new(nodes_element.name, nodes_element.id)
      if nodes_element.has_child?
        nodes_element.children.all? { |child_frag|
          node << build_tree(child_frag)
        }
      end
      node
    end

  end

end
