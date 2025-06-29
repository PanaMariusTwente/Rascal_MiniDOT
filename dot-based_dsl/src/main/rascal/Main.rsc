module Main

import IO;
import Prelude;
import Exception;

import grammar::MiniDOTGrammar;
import implementation::Checker;
import utils::Utils;

int main() {
    str graphExample = readFile(|project://dot-based_dsl/src/main/rascal/input/Graph.txt|);
    Graph g = parse(#start[Graph], graphExample).top;
    try {
        checker(g);
        // println("Successful parse: <g>");
        exportGraphToDot(g, |project://dot-based_dsl/src/main/rascal/output/exampleGraph.dot|);
        // println("Exported!");
    } catch Exception(msg): {
        println("Rejected parse: <msg>");
    }
    return 0;
}