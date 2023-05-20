package textMedley;

using StringTools;

#if macro
import haxe.macro.Expr;
#end

class OutputBlock {
	public var expressions:Array<Expression>;

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

	public function compile(compiler:textMedley.compilers.BaseCompiler) {
		return compiler.outputBlock(expressions);
	}

	#if macro
	public function toExpr() {
		var code:Array<Expr> = [];

		code.push(macro var i = Math.floor(Math.random() * $v{expressions.length}));

		for (i in 0...expressions.length) {
			var x = (macro if (i == $v{i}) {
				return ${expressions[i].toExpr()}
			});

			code.push(x);
		}

		code.push(macro return "");

		return code;
	}
	#end
}
