package compilers.haxe;

@:expose
class Compiler extends compilers.BaseCompiler {
	public override function new() {
		super();

		FUN_STD = Macros.importString("std.hx.tpl");
	}

	public override function global(str:String):String {
		var body = super.global(str);

		return 'class TextMedleyGen {\n${indent(body)}\n}';
	}

	public override function blockList(blocks:Map<String, Block>):String {
		return [
			for (block in blocks.keyValueIterator())
				'static public function ${makeName(block.key)}() {\n${indent(block.value.compile(this))}\n}'
		].join("\n\n");
	}

	public override function constBlock(consts:Array<String>):String {
		return consts.join("\n");
	}

	public override function const(name:String, content:String):String {
		return 'var ${name} = ${content};';
	}

	public override function outputBlock(exps:Array<Expression>):String {
		var lams = exps.map(exp -> '() -> ${exp.compile(this)}');
		return 'return pick_random([${lams.join(",\n")}])();';
	}

	public override function expression(exprs:Array<String>):String {
		return exprs.join(" + ");
	}

	public override function strToken(str:String):String {
		return '"${Utils.escape(str)}"';
	}

	public override function varToken(str:String):String {
		return str;
	}

	public override function blkToken(str:String):String {
		return '${makeName(str)}()';
	}
}