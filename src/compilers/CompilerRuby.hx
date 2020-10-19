package compilers;

using StringTools;

@:expose class CompilerRuby extends Compiler {

    static public function escape(str : String) {
        return str.replace("\\", "\\\\").replace("\"", "\\\"");
    }

    public override function global(str : String) : String {
        return "module TextMedley\nclass << self\ndef pick_random(arr);arr[rand(0...arr.length)];end\n\n" + str + "\nend\nend";
    }

    public override function blockList(blocks : Array<String>) : String {
        return blocks.join("\n\n");
    }

    public override function block(name : String, content : String) : String {
        return "def __" + name + "__\n" + content + "\nend";
    }

    public override function constBlock(consts : Array<String>) : String {
        return consts.join("/n");
    }

    public override function const(name : String, content : String) : String {
        return name + " = " + content;
    }

    public override function outputBlock(exps : Array<String>) : String {
        var lams = exps.map(function(exp) { return "lambda{ " + exp + " }"; });
        return "pick_random([" + lams.join(",\n") + "]).call()";
    }

    public override function output(str : String) : String {
        throw "To be implemented";
    }

    public override function expression(exprs : Array<String>) : String {
        return exprs.join(" + ");
    }

    public override function strToken(str : String) : String {
        return "\"" + escape(str) + "\"";
    }

    public override function varToken(str : String) : String {
        return str;
    }

    public override function blkToken(str : String) : String {
        return "__" + str + "__";
    }
}