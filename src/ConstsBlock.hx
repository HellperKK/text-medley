using StringTools;

class ConstsBlock {
    private var defs:Array<{name:String, content:Expression}>;

    public function new(content: String) {
        var trimmedContent = content
            .trim()
            .split("\n")
            .map(function(line) { return line.trim(); })
            .join("\n");
        
        defs = Utils.getBlock(trimmedContent, ~/\$([a-zA-Z]+) *= *(.+)/, function (reg) {
            return {
                name: reg.matched(1),
                content: new Expression(reg.matched(2))
            };
        });
    }

    public function eval(blocks : BlockList) {
        var res = new Map<String, String>();

        for (def in defs) {
            res.set(def.name, def.content.eval(blocks, res));
        }

        return res;
    }

    public function compile(compiler : Compiler) {
        return compiler.constBlock([
            for (bloc in defs) compiler.const(bloc.name, bloc.content.compile(compiler))
        ]);
    }
}