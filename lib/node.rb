require 'tree'
require_relative 'utils'

module LonelyPlanet
  # get node info by parsing a node fragement document
  class Node
    attr_reader :children

    # +nodes_fragement+ : a node fragement document
    def initialize(nodes_fragement)
      @nodes_xml = nodes_fragement
      @children = set_children
    end

    # get the node name
    def name
      nodename = @nodes_xml.at_css 'node_name'
      nodename.text
    end

    # return the geo_id of current node. 
    def id
      @nodes_xml['geo_id']
    end

    # return true if current node has a child or more children
    def has_child?
      !@children.empty?
    end

    private
    # return immediate children of current node
    def set_children
      @nodes_xml.element_children.filter 'node'
    end

  end

  class TreeNode < Tree::TreeNode
    # id is the only content needed
    alias id content
    include LonelyPlanet::Utils

    # return the hierarchy tree that will be shown on the right side bar
    def show_tree
      htmltree = ""
      self.each { |node| 
        htmltree += "<li><a href='#{normalize(node.name)}'>"
        htmltree += '&nbsp; ' * node.node_depth * 3
        htmltree += "#{node.name}</a></li>\n"
      }
      htmltree
    end

  end
end
