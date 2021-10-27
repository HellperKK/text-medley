package;

using StringTools;

class Block {
	static private var keys = ["vars", "output"];

	static public function parseBlock(block:String) {
		var trimmedBlock = block.trim();
		var subBlocks = Utils.getBlock(trimmedBlock, ~/-([a-z]+):(([^-]|\s)+)/, function(reg) {
			return {
				name: reg.matched(1),
				content: reg.matched(2)
			};
		});

		var subBlocksMap = [for (subBlock in subBlocks) subBlock.name => subBlock.content];
		for (key in subBlocksMap.keys()) {
			if (keys.indexOf(key) == -1) {
				return null;
			}
		}

		if (!subBlocksMap.exists("output")) {
			return null;
		}

		return new Block(subBlocksMap);
	}

	private var constsBlock:ConstsBlock;
	private var outputBlock:OutputBlock;

	public function new(blocks:Map<String, String>) {
		constsBlock = null;
		if (blocks.exists("vars")) {
			constsBlock = new ConstsBlock(blocks["vars"]);
		}
		outputBlock = new OutputBlock(blocks["output"]);
	}

	public function eval(blocks:BlockList) {
		var consts = new Map<String, String>();
		if (constsBlock != null) {
			consts = constsBlock.eval(blocks);
		}

		return outputBlock.eval(blocks, consts);
	}

	public function compile(compiler:compilers.BaseCompiler) {
		var constsStr = "";
		if (constsBlock != null) {
			constsStr = constsBlock.compile(compiler) + "\n";
		}

		return constsStr + outputBlock.compile(compiler);
	}
}
