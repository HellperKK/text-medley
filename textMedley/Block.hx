package textMedley;

import haxe.macro.Expr;
import textMedley.Expression;

using StringTools;

class Block extends BaseBlock {
	static private var keys = ["vars", "output"];

	private var constsBlock:ConstsBlock;
	private var name:String;

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

	public function eval(blocks:BlockList, params:Array<String>) {
		var consts = new Map<String, String>();

		for (i in 0...this.params.length) {
			consts.set(this.params[i], params[i]);
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

	public function mustBeCompiled() {
		return true;
	}

	#if macro
	public function toExpr(blocks:Map<String, BaseBlock>):Function {
		var code:Array<Expr> = if (constsBlock != null) constsBlock.toExpr(blocks).concat(outputBlock.toExpr(blocks)) else outputBlock.toExpr(blocks);

		var args:Array<FunctionArg> = this.params.map(param -> {
			name: param,
			meta: null,
			type: null,
			value: null,
			opt: null
		});
		return {
			expr: macro $b{code},
			args: $v{args},
			params: [],
			ret: null // (macro:String)
		};
	}
	#end
}
