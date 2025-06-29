module grammar::MiniDOTGrammar

import Prelude;


start syntax Graph
    = GraphDecl: STRICT? Dir Ident? "{" StmtList "}"
    ;

syntax Dir
    = UndirGraph: GRAPH
    | DirGraph: DIGRAPH
    ;

syntax StmtList
    = StmtDecl: (Stmt ";"?)*
    ;

syntax Stmt
    = NodeDecl: Ident AttrList?
    > EdgeDecl: Ident EdgeRHS+ AttrList?
    ;

syntax EdgeRHS
    = EdgeTarget: EdgeOp Ident
    ;

syntax EdgeOp
    = UndirEdge: "--"
    | DirEdge: "-\>"
    ;

syntax AttrList
    = AttrDecl: "[" AList* "]"
    ;

syntax AList
    = Attribute: Ident "=" Ident ","?
    ;

syntax Ident
    = Identifier: ID
    ;


// Keywords
keyword GRAPH = [gG][rR][aA][pP][hH];
keyword DIGRAPH = [dD][iI][gG][rR][aA][pP][hH];
keyword STRICT = [sS][tT][rR][iI][cC][tT];

// Content-bearing token types
lexical ID = [a-zA-Z_\u0080-\u00FF] !<< ([a-zA-Z_\u0080-\u00FF][a-zA-Z0-9_\u0080-\u00FF]*) !>> [a-zA-Z0-9_\u0080-\u00FF];

layout Layout = (Whitespace | Comment)* !>> [\ \t\n\r] !>> "//";

lexical Whitespace = [\ \t\n\r];
lexical Comment = @lineComment @category="Comment" "//" ![\n\r]* [\n\r];