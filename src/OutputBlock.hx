package;

using StringTools;

class OutputBlock {
	private var expressions:Array<Expression>;

	public function new(content:String) {
		var trimmedContent = content.trim();
		expressions = trimmedContent.split("\n").filter(line -> line != "").map(function(line) {
			return new Expression(line.trim());
		});
	}

	public function eval(blocks:BlockList, consts:Map<String, String>) {
		return pick_random().eval(blocks, consts);
	}

	public function pick_random() {
		var index = Math.floor(Math.random() * expressions.length);
		return expressions[index];
	}

	public function compile(compiler:compilers.BaseCompiler) {
		return compiler.outputBlock(expressions);
	}
}
