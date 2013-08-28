require 'set'

module MGraph
  class Edge
    attr_reader :vertices

    def initialize a, b
      @vertices = [a, b].to_set.freeze
    end

    def == other
      @vertices == other.vertices
    end
    alias_method :eql?, :==

    def hash
      self.class.hash ^ @vertices.hash
    end
  end
end
