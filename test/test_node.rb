require_relative 'common'
require 'doc'
require 'node'
require 'taxonomy'

module LonelyPlanet
  class TestNode < MiniTest::Test
    include LonelyPlanet::Test

    def setup
      @taxonomy_doc = LonelyPlanet::Doc.load TAXONOMY_FILE
      node_frag = @taxonomy_doc.css "[geo_id='355629']"
      @node = LonelyPlanet::Node.new node_frag.first
    end

    def test_name
      assert_equal "Sudan", @node.name
    end

    def test_id
      assert_equal "355629", @node.id
    end

    def test_has_child?
      assert @node.has_child?
    end

    def test_set_children
      assert_equal 2, @node.children.count
    end

    def test_treenode_id
      treenode = LonelyPlanet::TreeNode.new("root", 110)
      assert treenode.respond_to? 'id'
    end

    def test_show_tree
      taxonomy_doc = LonelyPlanet::Taxonomy.new TAXONOMY_FILE
      node_tree = taxonomy_doc.continents.first.show_tree
      assert node_tree.include?("Africa.html")
      assert node_tree.include?("&nbsp; &nbsp; &nbsp; South Africa")
    end
  end
end
