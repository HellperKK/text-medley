package textMedley;

import textMedley.compilers.BaseCompiler;
#if macro
import haxe.macro.Expr;
import haxe.macro.Context;
#end

using StringTools;

class ConstsBlock {
	private var defs:Array<{name:String, content:Expression}>;

	public function new(content:String) {
		defs = content.trim().split("\n").filter(line -> line != "").map(line -> {
			var leftPart = ~/\$([a-zA-Z]+)\s*=/;
			var trueLine = Utils.trimRight(line);

			if (!leftPart.match(trueLine)) {
				throw 'invalid const declaration in "${trueLine}"';
			}

			return {name: leftPart.matched(1), content: new Expression(leftPart.matchedRight())};
		});
	}

	public function eval(blocks:BlockList) {
		var res = new Map<String, String>();

		for (def in defs) {
			res.set(def.name, def.content.eval(blocks, res));
		}

		return res;
	}

	public function compile(compiler:BaseCompiler) {
		return compiler.constBlock([
			for (bloc in defs)
				compiler.const(bloc.name, bloc.content.compile(compiler))
		]);
	}

	#if macro
	public function toExpr(blocks:Map<String, BaseBlock>) {
		var code:Array<Expr> = [];

		for (pair in defs) {
			var id = pair.name;
			code.push(macro var $id = ${pair.content.toExpr(blocks)});
		}

		return code;
	}
	#end
}
