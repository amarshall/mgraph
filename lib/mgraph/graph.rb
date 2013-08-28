require 'mgraph/edge'
require 'mgraph/node'
require 'mgraph/vertex_edge_table'

require 'set'

module MGraph
  class Graph
    def initialize
      @graph_store = VertexEdgeTable.new
    end

    def add_edge v1, v2
      edge = Edge.new v1, v2
      @graph_store.add_edge edge
      edge
    end

    def breadth_first_traverse starting_vertex
      return enum_for(:breadth_first_traverse, starting_vertex) unless block_given?

      queue = [starting_vertex, *neighbors(starting_vertex)]
      visited = []
      while vertex = queue.shift
        yield vertex
        visited << vertex
        queue += neighbors(vertex).to_a - visited
        queue = queue.uniq
      end
    end

    def each_vertex
      return vertices.each unless block_given?
      vertices.each { |vertex| yield vertex }
    end

    def edges
      @graph_store.edges
    end

    def has_edge? v1, v2
      edge = Edge.new v1, v2
      edges.include? edge
    end

    def has_vertex? vertex
      vertices.include? vertex
    end

    def neighbors vertex
      neighbors = edges_for(vertex).map(&:vertices).reduce(:+)
      (neighbors || Set.new) - [vertex]
    end

    def vertices
      @graph_store.vertices
    end

    private

    def edges_for vertex
      @graph_store[vertex]
    end
  end
end
