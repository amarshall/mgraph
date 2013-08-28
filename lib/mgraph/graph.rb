require 'mgraph/edge'

require 'set'

module MGraph
  class Graph
    def initialize
      @edges = Set.new
    end

    def add_edge v1, v2
      edge = Edge.new v1, v2
      @edges << edge
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
      @edges.dup.freeze
    end

    def has_edge? v1, v2
      edge = Edge.new v1, v2
      @edges.include? edge
    end

    def has_vertex? vertex
      vertices.include? vertex
    end

    def neighbors vertex
      neighbors = edges_for(vertex).map(&:vertices).reduce(:+)
      (neighbors || Set.new) - [vertex]
    end

    def vertices
      @edges.map(&:vertices).reduce(:+)
    end

    private

    def edges_for vertex
      lookup_table.fetch(vertex, Set.new)
    end

    def lookup_table
      @edges.each_with_object({}) do |edge, lookup_table|
        edge.vertices.each do |vertex|
          (lookup_table[vertex] ||= Set.new) << edge
        end
      end.freeze
    end
  end
end
