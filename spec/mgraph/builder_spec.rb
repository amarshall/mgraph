require 'mgraph/builder'

describe MGraph::Builder do
  it "builds a graph given a starting object and a way to get its neighbors" do
    neighbor_get = ->(vertex) { vertex.neighbors }
    builder = MGraph::Builder.new(neighbor_get)
    l2_1_neighbors = [double(neighbors: [])]
    l2_2_neighbors = [double(neighbors: [])]
    root_neighbors = [
      double(neighbors: l2_1_neighbors),
      double(neighbors: l2_2_neighbors),
    ]
    root = double neighbors: root_neighbors

    graph = builder.build root

    expect(graph.vertices).to eq [
      root,
      *root_neighbors,
      *l2_1_neighbors,
      *l2_2_neighbors,
    ].to_set
  end

  it "can handle circular graphs" do
    neighbor_get = ->(vertex) { vertex.neighbors }
    builder = MGraph::Builder.new(neighbor_get)
    root = double
    l2_1_neighbors = [double(neighbors: [root])]
    l2_2_neighbors = [double(neighbors: [])]
    root_neighbors = [
      double(neighbors: l2_1_neighbors),
      double(neighbors: l2_2_neighbors),
    ]
    root.stub(:neighbors).and_return root_neighbors

    graph = builder.build root

    expect(graph.vertices).to eq [
      root,
      *root_neighbors,
      *l2_1_neighbors,
      *l2_2_neighbors,
    ].to_set
  end
end
