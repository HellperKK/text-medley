package textMedley;

import haxe.macro.Expr;
import textMedley.Expression;

using StringTools;

class FunctionBlock extends BaseBlock {
	static private var keys = ["vars", "output"];

	private var name:String;
	private var content:(Array<String>) -> String;

	public function new(name:String, content:(Array<String>) -> String) {
		this.name = name;
		this.content = content;
	}

	public function eval(blocks:BlockList, params:Array<Expression>) {
		return content(params.map(param -> param.eval(blocks, new Map<String, String>())));
	}

	public function compile(compiler:textMedley.compilers.BaseCompiler) {
		return "";
	}

	#if macro
	public function toExpr():Function {
		throw "Not implemented";
	}
	#end
}
