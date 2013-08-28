require 'mgraph/edge'

describe MGraph::Edge do
  it "contains an undirected pair of objects" do
    v1, v2 = double, double
    edge = MGraph::Edge.new v1, v2
    expect(edge.vertices).to eq [v1, v2].to_set
  end

  it "does not allow modification of its vertices" do
    v1, v2 = double, double
    edge = MGraph::Edge.new v1, v2
    expect { edge.vertices << double }.to raise_error(/frozen/i)
  end

  describe "equality" do
    it "is `equal` to itself" do
      edge = MGraph::Edge.new double, double

      expect(edge == edge).to eq true
      expect(edge.eql?(edge)).to eq true
      expect(edge.equal?(edge)).to eq true
    end

    it "is equal to another Edge with the same vertices" do
      v1, v2 = double, double
      a = MGraph::Edge.new v1, v2
      b = MGraph::Edge.new v2, v1

      expect(a == b).to eq true
      expect(a.eql?(b)).to eq true
      expect(a.equal?(b)).to eq false
    end

    it "is not equal to another Edge with different vertices" do
      v1, v2, v3 = double, double, double
      a = MGraph::Edge.new v1, v2
      b = MGraph::Edge.new v2, v3

      expect(a == b).to eq false
      expect(a.eql?(b)).to eq false
      expect(a.equal?(b)).to eq false
    end
  end

  describe "#hash" do
    it "is the same for Edges with the same vertices" do
      v1, v2 = double, double
      a = MGraph::Edge.new v1, v2
      b = MGraph::Edge.new v2, v1

      expect(a.hash).to eq b.hash
    end

    it "is different for Edges with different vertices" do
      v1, v2, v3 = double, double, double
      a = MGraph::Edge.new v1, v2
      b = MGraph::Edge.new v2, v3

      expect(a.hash).to_not eq b.hash
    end
  end
end
