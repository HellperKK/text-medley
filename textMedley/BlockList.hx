package textMedley;

import haxe.macro.Expr.FieldType;
import haxe.macro.Expr.Access;
import haxe.Json;
#if macro
import haxe.macro.Context;
#end

using StringTools;

@:expose
class BlockList {
	static private var recMax = 500;

	private var blocks:Map<String, BaseBlock>;
	private var recCount:Int = 0;

	public function new(input:String) {
		var blockStart = ~/#([a-zA-Z]+)(\(([^)]*?)\))?/;
		var blockEnd = ~/#end/;
		var inputPart = input;
		initLib();

		while (blockStart.match(inputPart)) {
			var part = blockStart.matchedRight();
			var ruleName = blockStart.matched(1);
			var params = if (blockStart.matched(3) != null) blockStart.matched(3).split(",").map(arg -> {
				var reg = ~/\$([a-zA-Z]+)/;
				if (reg.match(arg)) {
					return reg.matched(1);
				} else {
					throw 'invalid param name ${arg}';
				}
			}) else [];

			if (!blockEnd.match(part)) {
				throw 'no closing "#end" for rule "#${ruleName}"';
			}

			blocks.set(ruleName, new Block(ruleName, params, blockEnd.matchedLeft()));
			inputPart = blockEnd.matchedRight();
		}

		// comment for regex shame
		// ~/#([a-zA-Z]+?)(\((\$[a-zA-Z]+( *, *\$[a-zA-Z]+)*)\))?:((.|\s)+?)end#/
	}

	public function initLib() {
		blocks = new Map<String, BaseBlock>();

		blocks.set("if", new FunctionBlock("if", Definitions.condition));
	}

	public function eval(name:String, params:Array<Expression> = null) {
		if (params == null) {
			params = [];
		}

		if (recCount == recMax) {
			throw "Max recursion reached";
		}

		recCount += 1;
		var ret = blocks[name].eval(this, params);
		recCount -= 1;

		return ret;
	}

	public function eval_main() {
		if (!blocks.exists("main")) {
			throw "missing main block";
		}

		return eval("main");
	}

	public function compile(compiler:textMedley.compilers.BaseCompiler) {
		var res = compiler.blockList(blocks);

		return compiler.global(res);
	}

	public function toJson() {
		return Json.stringify(this, "  ");
	}

	#if macro
	public function toExpr() {
		return [
			for (pair in blocks.keyValueIterator())
				{
					name: pair.key,
					access: [Access.APublic, Access.AStatic],
					kind: FieldType.FFun(pair.value.toExpr()),
					doc: "generated by text-meldey macro",
					meta: null,
					pos: Context.currentPos(),
				}
		];
	}
	#end
}
