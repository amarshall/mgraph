module MGraph
  class VertexEdgeTable
    def initialize
      @vertex_edges = {}
    end

    def << edge
      add_edge(edge)
      self
    end

    def add_edge edge
      edge.vertices.each do |vertex|
        (@vertex_edges[vertex] ||= Set.new) << edge
      end
    end

    def edges
      @vertex_edges.values.reduce(Set.new, :+).freeze
    end

    def incident_edges vertex
      @vertex_edges.fetch(vertex, Set.new)
    end

    def neighbors vertex
      adjacencies = incident_edges(vertex).map(&:vertices).reduce(:+) || Set.new
      adjacencies - [vertex]
    end

    def vertices
      @vertex_edges.keys.to_set
    end
  end
  private_constant :VertexEdgeTable
end
