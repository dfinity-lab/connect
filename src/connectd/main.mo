import Digraph "./Digraph";
import Types "./types";

type Vertex = Types.Vertex;

actor Connectd {
  var graph: Digraph.Digraph = Digraph.Digraph();

  public func healthcheck(): async Bool { true };

  public func connect(userA: Vertex, userB: Vertex): async () {
    graph.addEdge(userA, userB);
  };

  public func getConnections(user: Vertex): async [Vertex] {
    graph.getAdjacent(user)
  };

};
