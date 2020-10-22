package src.compilers.ocaml;

@:build(src.Macros.importStaticString("FUN_STD", "std.ml"))
@:expose
class Compiler extends BaseCompiler {

    public function makeFun(pair : {key:String, value:Block}, rec : String) : String {
        var newName = makeName(pair.key);
        return '${rec} ${newName} () =\n${indent(pair.value.compile(this))}';
    }

    public override function global(str : String) : String {
        return [
            FUN_STD,
            str
        ].join("\n\n");
    }

    public override function blockList(blocks : Map<String, Block>) : String {
        var pairs = [
            for (block in blocks.keyValueIterator())
                block
        ];

        var defs = [
            for (i in 0...pairs.length)
                if (i == 0)
                    makeFun(pairs[i], 'let rec')
                else
                    makeFun(pairs[i], 'and')
        ];

        return defs.join("\n\n");
    }

    public override function constBlock(consts : Array<String>) : String {
        return consts.join("/n");
    }

    public override function const(name : String, content : String) : String {
        return "let " + name + " = " + content + " in";
    }

    public override function outputBlock(exps : Array<Expression>) : String {
        var lams = exps.map(function(exp) { return "(function () -> (" + exp.compile(this) + "))"; });
        return "pick_random [|\n" + indent(lams.join(";\n")) + "\n|] ()";
    }

    public override function expression(exprs : Array<String>) : String {
        return exprs.join(" ^ ");
    }

    public override function strToken(str : String) : String {
        return "\"" + Utils.escape(str) + "\"";
    }

    public override function varToken(str : String) : String {
        return str;
    }

    public override function blkToken(str : String) : String {
        return '(${makeName(str)} ())';
    }
}