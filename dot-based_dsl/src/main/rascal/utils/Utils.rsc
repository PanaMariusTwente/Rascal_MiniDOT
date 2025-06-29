module utils::Utils

import IO;

import grammar::MiniDOTGrammar;
import implementation::ASTWalker;

public void exportGraphToDot(Graph g, loc filePath) {
  writeFile(filePath, toDot(g));
}