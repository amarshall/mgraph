module MGraph
  class VertexEdgeTable
    def initialize
      @vertex_edges = {}
    end

    def [] vertex
      @vertex_edges.fetch(vertex, Set.new)
    end

    def add vertex, edge
      (@vertex_edges[vertex] ||= Set.new) << edge
    end

    def add_edge edge
      edge.vertices.each { |vertex| add(vertex, edge) }
    end

    def edges
      @vertex_edges.values.reduce(Set.new, :+).freeze
    end

    def vertices
      @vertex_edges.keys.to_set
    end
  end
  private_constant :VertexEdgeTable
end
