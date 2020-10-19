@:expose class Compiler {

    public function new() {

    }

    public function global(str : String) : String {
        throw "To be implemented";
    }

    public function blockList(blocks : Array<String>) : String {
        throw "To be implemented";
    }

    public function block(name : String, content : String) : String {
        throw "To be implemented";
    }

    public function constBlock(consts : Array<String>) : String {
        throw "To be implemented";
    }

    public function const(name : String, content : String) : String {
        throw "To be implemented";
    }

    public function expression(str : Array<String>) : String {
        throw "To be implemented";
    }

    public function outputBlock(exps : Array<String>) : String {
        throw "To be implemented";
    }

    public function output(str : String) : String {
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