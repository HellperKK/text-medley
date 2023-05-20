package textMedley;

import haxe.macro.Expr;
import textMedley.Expression;

using StringTools;

class Block {
	static private var keys = ["vars", "output"];

	private var constsBlock:ConstsBlock;
	private var name:String;

	public var params:Array<String>;
	public var outputBlock:textMedley.OutputBlock;

	public function new(name:String, params:Array<String>, content:String) {
		this.name = name;
		this.params = params;
		constsBlock = null;
		outputBlock = null;

		parseBlock(content);
	}

	public function parseBlock(input:String) {
		var blockStart = ~/-([a-zA-Z]+):/;
		var inputPart = input;

		while (blockStart.match(inputPart)) {
			var part = blockStart.matchedRight();
			var blockName = blockStart.matched(1);

			if (!keys.contains(blockName)) {
				throw 'invalid block name "-${blockName}"';
			}

			if (blockStart.match(part)) {
				addBlock(blockName, blockStart.matchedLeft());
				inputPart = part.substr(blockStart.matchedPos().pos);
			} else {
				addBlock(blockName, part);
				inputPart = "";
			}
		}
	}

	public function addBlock(name:String, content:String) {
		switch (name) {
			case "vars":
				constsBlock = new ConstsBlock(content);
			case "output":
				outputBlock = new OutputBlock(content);
			case _:
				throw "should not happen";
		}
	}

	public function eval(blocks:BlockList, params:Array<Expression>) {
		var consts = new Map<String, String>();

		for (i in 0...this.params.length) {
			consts.set(this.params[i], params[i].eval(blocks, consts));
		}

		if (constsBlock != null) {
			consts = constsBlock.eval(blocks);
		}

		return outputBlock.eval(blocks, consts);
	}

	public function compile(compiler:textMedley.compilers.BaseCompiler) {
		var constsStr = "";
		if (constsBlock != null) {
			constsStr = constsBlock.compile(compiler) + "\n";
		}

		return constsStr + outputBlock.compile(compiler);
	}

	#if macro
	public function toExpr() {
		var code:Array<Expr> = if (constsBlock != null) constsBlock.toExpr().concat(outputBlock.toExpr()) else outputBlock.toExpr();

		return {
			expr: macro $b{code},
			args: [],
			params: [],
			ret: null // (macro:String)
		};
	}
	#end
}
