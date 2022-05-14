package compilers.javascript;

using Lambda;

@:expose
class Compiler extends BaseCompiler {
	public override function new() {
		super();

		FUN_STD = Macros.importString("std.js");
	}

	public override function blockList(blocks:Map<String, Block>):String {
		var defs = [
			for (block in blocks.keyValueIterator())
				'function ${makeName(block.key)}(){\n${indent(block.value.compile(this))}\n}'
		];

		return defs.join("\n\n");
	}

	public override function constBlock(consts:Array<String>):String {
		return consts.join("\n");
	}

	public override function const(name:String, content:String):String {
		return "let " + name + " = " + content + ";";
	}

	public override function outputBlock(exps:Array<Expression>):String {
		var lams = exps.mapi((index, exp) -> {
			return 'if (_rand === ${index}) {\n${indent("return " + exp.compile(this) + ";")}\n}';
			// return "(() => " + exp.compile(this) + ")";
		}).join("\n");
		return 'const _rand = randomNum(${exps.length});\n${lams}';
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
		return makeName(str) + "()";
	}
}
