module MGraph
  class Builder
    def initialize neighbor_retriever
      @neighbor_retriever = neighbor_retriever
      freeze
    end

    def build root
      graph = Graph.new
      traverse_and_build graph, root
    end

    private

    def traverse_and_build graph, vertex
      neighbors = @neighbor_retriever.(vertex)

      neighbors.reject do |neighbor|
        graph.has_edge? vertex, neighbor
      end.each do |neighbor|
        graph.add_edge vertex, neighbor
        traverse_and_build graph, neighbor
      end

      graph
    end
  end
end
