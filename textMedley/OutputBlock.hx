package textMedley;

using StringTools;
using Lambda;

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
		return  pick_random().eval(blocks, consts);
	}

	public function pick_random() {
		var totalWeight = getWeightSum();

		var randomValue = Math.floor(Math.random() * totalWeight);

		var minWeight = 0;

		for (expression in expressions) {
			if (randomValue < expression.weight + minWeight) {
				return expression;
			}

			minWeight += expression.weight;
		}

		return expressions[expressions.length - 1];
	}

	public function compile(compiler:textMedley.compilers.BaseCompiler) {
		return compiler.outputBlock(expressions);
	}

	public function getWeightSum() {
		return expressions.fold(function(expression, total) {
			return total + expression.weight;
		}, 0);
	}

	#if macro
	public function toExpr(blocks:Map<String, BaseBlock>) {
		var totalWeight = getWeightSum();

		var code:Array<Expr> = [];
		var sum = 0;

		code.push(macro var i = Std.random($v{totalWeight}));
		// code.push(macro var sum = 0);

		for (i in 0...expressions.length) {
			var x = (macro if (i < $v{expressions[i].weight + sum}) {
				return ${expressions[i].toExpr(blocks)}
			});
			sum += expressions[i].weight;

			code.push(x);
			// code.push(macro sum += $v{expressions[i].weight});
		}

		code.push(macro return "");

		return code;
	}
	#end
}
