package;

import haxe.Json;

@:expose
class BlockList {
	static private var recMax = 500;

	private var blocks:Map<String, Block>;
	private var recCount:Int;

	public function new(inp:String) {
		recCount = 0;

		var tempBlocks = Utils.getBlock(inp, ~/#(.+?):((.|\s)+?)end#/, function(reg) {
			return {
				name: reg.matched(1),
				content: Block.parseBlock(reg.matched(2))
			};
		});

		blocks = [
			for (block in tempBlocks)
				if (block.content != null) block.name => block.content
		];
	}

	public function eval(name:String) {
		if (recCount == recMax) {
			throw "Max recursion reached";
		}

		recCount += 1;
		var ret = blocks[name].eval(this);
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
