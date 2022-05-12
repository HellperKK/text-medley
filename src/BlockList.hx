package;

import haxe.Json;

using StringTools;

@:expose
class BlockList {
	static private var recMax = 500;

	private var blocks:Map<String, Block>;
	private var recCount:Int = 0;

	public function new(input:String) {
		var blockStart = ~/#([a-zA-Z]+)/;
		var blockEnd = ~/#end/;
		var inputPart = input;
		blocks = new Map<String, Block>();

		while (blockStart.match(inputPart)) {
			var part = blockStart.matchedRight();
			var ruleName = blockStart.matched(1);

			if (!blockEnd.match(part)) {
				throw 'no closing "#end" for rule "#${ruleName}"';
			}

			blocks.set(ruleName, new Block(ruleName, [], blockEnd.matchedLeft()));
			inputPart = blockEnd.matchedRight();
		}

		// comment for regex shame
		// ~/#([a-zA-Z]+?)(\((\$[a-zA-Z]+( *, *\$[a-zA-Z]+)*)\))?:((.|\s)+?)end#/
	}

	public function eval(name:String, params:Array<Token> = null) {
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

	public function compile(compiler:compilers.BaseCompiler) {
		var res = compiler.blockList(blocks);

		return compiler.global(res);
	}

	public function toJson() {
		return Json.stringify(this, "  ");
	}
}
