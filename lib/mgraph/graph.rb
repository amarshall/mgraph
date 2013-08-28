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
      neighbors = @edges.select do |edge|
        edge.vertices.include? vertex
      end.map(&:vertices).reduce(:+)
      (neighbors || Set.new) - [vertex]
    end

    def vertices
      @edges.map(&:vertices).reduce(:+)
    end
  end
end
