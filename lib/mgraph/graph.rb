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

    def edges
      @edges.dup.freeze
    end

    def has_edge? v1, v2
      edge = Edge.new v1, v2
      @edges.include? edge
    end

    def has_vertex? vertex
      @edges.map(&:vertices).reduce(:+).include? vertex
    end
  end
end
