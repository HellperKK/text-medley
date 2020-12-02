package src;

class Expression {
    private var tokens:Array<Token>;

    public function new(content: String) {
        tokens = Utils.getBlock(content, ~/(([^#\$]+)|(#[a-zA-Z]+)|(\$[a-zA-Z]+))/, function (reg) {
            var tok = reg.matched(1);

            var reg = ~/#([a-zA-Z]+)/;
            if (reg.match(tok)) return Blk(reg.matched(1));

            var reg = ~/\$([a-zA-Z]+)/;
            if (reg.match(tok)) return Var(reg.matched(1));

            return Str(tok);
        });
    }

    public function eval(blocks : BlockList, consts : Map<String, String>) {
        return [
            for (token in tokens)
                switch (token) {
                    case Str(content): 
                        Utils.escape_interp(content);
                    case Var(name):
                        consts[name];
                    case Blk(name):
                        blocks.eval(name);
                }
        ].join("");
    }

    public function compile(compiler : src.compilers.BaseCompiler) {
        return compiler.expression([
            for (token in tokens)
                switch (token) {
                    case Str(content):
                        compiler.strToken(content);
                    case Var(name):
                        compiler.varToken(name);
                    case Blk(name):
                        compiler.blkToken(name);
                }
        ]);
    }

    public function getTokenNames() {
        return tokens.map(function (token) {
            return switch (token) {
                case Var(name):
                    name;
                case _:
                    "";
            }
        })
        .filter(function (name) {
            return name != "";
        });
    }
}