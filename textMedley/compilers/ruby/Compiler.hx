package textMedley.compilers.ruby;

using Lambda;

@:expose
class Compiler extends BaseCompiler {
	public function new() {
		super();

		FUN_STD = ""; // Macros.importString("std.rb");
	}

	public function blockList(blocks:Map<String, Block>):String {
		var defs = [
			for (block in blocks.keyValueIterator())
				'def ${makeName(block.key)}\n${indent(block.value.compile(this))}\nend'
		];

		return defs.join("\n\n");
	}

	public function constBlock(consts:Array<String>):String {
		return consts.join("\n");
	}

	public function const(name:String, content:String):String {
		return name + " = " + content;
	}

	public function outputBlock(exps:Array<Expression>):String {
		var lams = exps.mapi((index, exp) -> 'if _rand == ${index}\n${indent("return " + exp.compile(this))}\nend');
		return '_rand = rand(0...${exps.length})\n${lams.join('\n')}';
	}

	public function expression(exprs:Array<String>):String {
		return exprs.join(" + ");
	}

	public function strToken(str:String):String {
		return "\"" + Utils.escape(str) + "\"";
	}

	public function varToken(str:String):String {
		return str;
	}

	public function blkToken(str:String, params:Array<Expression>):String {
		return makeName(str);
	}
}
