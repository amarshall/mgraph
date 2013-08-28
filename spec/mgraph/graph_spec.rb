require 'mgraph/graph'

describe MGraph::Graph do
  describe "#add_edge" do
    it "accepts edges as two vertices, returning the Edge" do
      v1, v2, = double, double
      edge = double
      graph = MGraph::Graph.new
      MGraph::Edge.stub(:new).with(v1, v2).and_return edge

      returned = graph.add_edge v1, v2

      expect(returned).to eq edge
    end
  end

  describe "#each_vertex" do
    it "yields each vertex to the given block" do
      vertices = [double, double, double, double]
      graph = MGraph::Graph.new
      vertices.each_cons(2) { |v1, v2| graph.add_edge v1, v2 }

      yielded = []
      graph.each_vertex { |v| yielded << v }

      expect(yielded).to eq vertices
    end

    it "returns an Enumerator when no block is given" do
      vertices = [double, double, double, double]
      graph = MGraph::Graph.new
      vertices.each_cons(2) { |v1, v2| graph.add_edge v1, v2 }

      enumerator = graph.each_vertex

      expect(enumerator).to be_a Enumerator
      expect(enumerator.to_a).to eq vertices
    end
  end

  describe "#edges" do
    it "returns all the edges" do
      v1, v2, v3, v4 = double, double
      edge_1, edge_2 = double, double
      graph = MGraph::Graph.new
      MGraph::Edge.stub(:new).with(v1, v2).and_return edge_1
      MGraph::Edge.stub(:new).with(v3, v4).and_return edge_2

      graph.add_edge v1, v2
      graph.add_edge v3, v4

      expect(graph.edges).to eq [edge_1, edge_2].to_set
    end

    it "does not allow modification of the edges" do
      graph = MGraph::Graph.new
      expect{ graph.edges << double }.to raise_error(/frozen/i)
    end
  end

  describe "#has_edge?" do
    it "returns true if there is an edge between the given vertices" do
      v1, v2, = double, double
      graph = MGraph::Graph.new
      graph.add_edge v1, v2

      expect(graph.has_edge?(v1, v2)).to eq true
      expect(graph.has_edge?(v2, v1)).to eq true
    end

    it "returns false if there is not an edge between the given vertices" do
      v1, v2, = double, double
      graph = MGraph::Graph.new
      graph.add_edge v1, v2

      expect(graph.has_edge?(v1, double)).to eq false
      expect(graph.has_edge?(double, v2)).to eq false
    end
  end

  describe "#has_vertex?" do
    it "returns true if the vertex has been added" do
      v1, v2, = double, double
      graph = MGraph::Graph.new
      graph.add_edge v1, v2

      expect(graph.has_vertex?(v1)).to eq true
      expect(graph.has_vertex?(v2)).to eq true
    end

    it "returns false if the vertex has not been added" do
      v1, v2, = double, double
      graph = MGraph::Graph.new
      graph.add_edge v1, v2

      expect(graph.has_vertex?(double)).to eq false
    end
  end

  describe "#neighbors" do
    it "returns an empty set when the vertex doesn't exist" do
      graph = MGraph::Graph.new
      expect(graph.neighbors(double)).to eq Set.new
    end

    it "returns the neighbors of a given vertex" do
      neighbors = [double, double, double]
      not_neighbors = [double, double, double]
      vertex = [double]
      graph = MGraph::Graph.new
      neighbors.each { |neighbor| graph.add_edge vertex, neighbor }
      neighbors.zip(not_neighbors) { |v1, v2| graph.add_edge v1, v2 }

      expect(graph.neighbors(vertex)).to eq neighbors.to_set
    end
  end

  describe "#vertices" do
    it "returns a set with all the added vertices" do
      vertices = [double, double, double, double]
      graph = MGraph::Graph.new
      vertices.each_cons(2) { |v1, v2| graph.add_edge v1, v2 }

      expect(graph.vertices).to eq vertices.to_set
    end
  end
end
