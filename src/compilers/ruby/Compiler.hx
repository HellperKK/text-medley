package compilers.ruby;

using Lambda;

@:expose
class Compiler extends BaseCompiler {
	public override function new() {
		super();

		FUN_STD = ""; // Macros.importString("std.rb");
	}

	public override function blockList(blocks:Map<String, Block>):String {
		var defs = [
			for (block in blocks.keyValueIterator())
				'def ${makeName(block.key)}\n${indent(block.value.compile(this))}\nend'
		];

		return defs.join("\n\n");
	}

	public override function constBlock(consts:Array<String>):String {
		return consts.join("\n");
	}

	public override function const(name:String, content:String):String {
		return name + " = " + content;
	}

	public override function outputBlock(exps:Array<Expression>):String {
		var lams = exps.mapi((index, exp) -> 'if _rand == ${index}\n${indent("return " + exp.compile(this))}\nend');
		return '_rand = rand(0...${exps.length})\n${lams.join('\n')}';
	}

	public override function expression(exprs:Array<String>):String {
		return exprs.join(" + ");
	}

	public override function strToken(str:String):String {
		return "\"" + Utils.escape(str) + "\"";
	}

	public override function varToken(str:String):String {
		return str;
	}

	public override function blkToken(str:String):String {
		return makeName(str);
	}
}
