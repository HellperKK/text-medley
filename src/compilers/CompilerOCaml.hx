package compilers;

using StringTools;

@:expose class CompilerOCaml extends Compiler {

    static public function escape(str : String) {
        return str.replace("\\", "\\\\").replace("\"", "\\\"");
    }

    public override function global(str : String) : String {
        return "let _ = Random.self_init ()\n"
            + "let pick_random arr = arr.(Random.int (Array.length arr))\n"
            + "let hash_ = Hashtbl.create 10\n"
            + "let replace_name = Hashtbl.replace hash_\n"
            + "let find_name = Hashtbl.find hash_\n\n" 
            + str;
    }

    public override function blockList(blocks : Array<String>) : String {
        return blocks.join("\n\n");
    }

    public override function block(name : String, content : String) : String {
        var newName = "__" + name + "__";
        return "let " + newName + " () =\n" + content + "\nlet _ = replace_name \"" + newName + "\" " + newName;
    }

    public override function constBlock(consts : Array<String>) : String {
        return consts.join("/n");
    }

    public override function const(name : String, content : String) : String {
        return "let " + name + " = " + content + " in";
    }

    public override function outputBlock(exps : Array<String>) : String {
        var lams = exps.map(function(exp) { return "(function () -> " + exp + ")"; });
        return "pick_random [|" + lams.join(";\n") + "|] ()";
    }

    public override function output(str : String) : String {
        throw "To be implemented";
    }

    public override function expression(exprs : Array<String>) : String {
        return "(" + exprs.join(" ^ ") + ")";
    }

    public override function strToken(str : String) : String {
        return "\"" + escape(str) + "\"";
    }

    public override function varToken(str : String) : String {
        return str;
    }

    public override function blkToken(str : String) : String {
        var newName = "__" + str + "__";
        return "(find_name \"" + newName + "\"  ())";
    }
}