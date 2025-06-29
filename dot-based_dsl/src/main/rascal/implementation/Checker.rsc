module implementation::Checker

import IO;
import String;
import Exception;

import grammar::MiniDOTGrammar;

set[str] keywords = {"graph", "digraph", "node", "edge", "subgraph", "strict"};
public data Exception = Exception(str msg);

public void checker(Graph tree) {
  keywordFilter(tree);
  edgeChecker(tree);
}

void keywordFilter(Graph tree) {
  top-down visit(tree) {
    case Identifier(ID id):
      checkID("<id>");
  }
}

void checkID(str id) {
  if (toLowerCase(id) in keywords) {
    throw Exception("ID is a reserved keyword: <id>!");
  }
}

void edgeChecker(Graph tree) {
  bool directional = false;
  top-down visit(tree) {
    case DirGraph(_):
      directional = true;
    case DirEdge():
      if (!directional) {
        throw Exception("Directed edge in undirected graph!");
      }
    case UndirEdge():
      if (directional) {
        throw Exception("Undirected edge in directed graph!");
      }
  }
}