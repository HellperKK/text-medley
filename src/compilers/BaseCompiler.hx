package src.compilers;

using StringTools;

@:expose
class BaseCompiler {

    public function new() {

    }

    public function indent(code : String) {
        return indentString() + code.replace('\n', '\n${indentString()}');
    }

    public function indentString() {
        return "    ";
    }

    public function makeName(name : String) {
        return '__${name}__';
    }

    public function global(str : String) : String {
        throw "To be implemented";
    }

    public function blockList(blocks : Map<String, Block>) : String {
        throw "To be implemented";
    }

    public function constBlock(consts : Array<String>) : String {
        throw "To be implemented";
    }

    public function const(name : String, content : String) : String {
        throw "To be implemented";
    }

    public function outputBlock(exps : Array<Expression>) : String {
        throw "To be implemented";
    }

    public function expression(str : Array<String>) : String {
        throw "To be implemented";
    }

    public function strToken(str : String) : String {
        throw "To be implemented";
    }

    public function varToken(str : String) : String {
        throw "To be implemented";
    }

    public function blkToken(str : String) : String {
        throw "To be implemented";
    }
}