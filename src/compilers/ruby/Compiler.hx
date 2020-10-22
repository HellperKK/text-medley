package src.compilers.ruby;

@:build(src.Macros.importStaticString("FUN_STD", "std.rb"))
@:expose 
class Compiler extends BaseCompiler {

    public override function global(str : String) : String {
        return [
            FUN_STD,
            str
        ].join("\n\n");
    }

    public override function blockList(blocks : Map<String, Block>) : String {
        var defs = [
            for (block in blocks.keyValueIterator())
                'def ${makeName(block.key)}\n${indent(block.value.compile(this))}\nend'
        ];

        return defs.join("\n\n");
    }

    public override function constBlock(consts : Array<String>) : String {
        return consts.join("/n");
    }

    public override function const(name : String, content : String) : String {
        return name + " = " + content;
    }

    public override function outputBlock(exps : Array<Expression>) : String {
        var lams = exps.map(function(exp) { return "lambda{ " + exp.compile(this) + " }"; });
        return "pick_random([\n" + indent(lams.join(",\n")) + "\n]).call()";
    }

    public override function expression(exprs : Array<String>) : String {
        return exprs.join(" + ");
    }

    public override function strToken(str : String) : String {
        return "\"" + Utils.escape(str) + "\"";
    }

    public override function varToken(str : String) : String {
        return str;
    }

    public override function blkToken(str : String) : String {
        return makeName(str);
    }
}