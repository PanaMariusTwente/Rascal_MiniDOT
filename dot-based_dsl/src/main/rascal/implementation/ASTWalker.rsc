module implementation::ASTWalker

import grammar::MiniDOTGrammar;
import Prelude;

str toDot(Graph tree) {
  result = "";
  switch (tree) {
    case GraphDecl(STRICT? strict, Dir graphType, Ident? id, StmtList s): {
      if (size("<strict>") != 0) {
        result += "<strict> ";
      }
      result += "<graphType>";
      if (implode(#bool, id)) {
        result += " " +  toDot(id[0]);
      }
      result += " {\n" + toDot(s) + "}";
    }
  }
  return result;
}

str toDot(StmtList tree) {
  str result = "";
  switch (tree) {
    case StmtDecl(stmts): {
      for (t <- stmts) {
        result += "    " + toDot(t[0]) + "<t[1]>" + "\n";
      }
    }
  }
  return result;
}

str toDot(Stmt tree) {
  str result = "";
  switch (tree) {
    case NodeDecl(Ident id, AttrList? attrs):
      return toDot(id) + maybeAttrs(attrs);
    case EdgeDecl(Ident id, EdgeRHS+ rhs, AttrList? attrs): {
      result += toDot(id);
      for (edge <- rhs) {
        result += " " + toDot(edge);
      }
      result += maybeAttrs(attrs);
    }
  }
  return result;
}

str toDot(EdgeRHS tree) {
  switch (tree) {
    case EdgeTarget(EdgeOp op, Ident id):
      return "<op>" + " " + toDot(id);
    default: return "";
  }
}

str toDot(AttrList tree) {
  result = "";
  switch (tree) {
    case AttrDecl(attrs): {
      result += "[";
      for (attr <- attrs) {
        result += toDot(attr[0]) + "=" + toDot(attr[1]) + "<attr[2]> ";
      }
      // Remove last space delimiter if there are any elements
      if (size(result) > 1) {
        result = result[..size(result) - 1];
      }
      result += "]";
    }
  }
  return result;
}

str maybeAttrs(AttrList? a) {
  if (implode(#bool, a)) {
    return " " + toDot(a[0]);
  } else {
    return "";
  }
}

str toDot(Ident tree) {
  switch (tree) {
    case Identifier(ID id):
      return "<id>";
    default: return "";
  }
}

str toDot(Tree tree) {
  return "fail.";
}