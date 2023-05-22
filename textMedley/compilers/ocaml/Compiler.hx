package textMedley.compilers.ocaml;

@:expose
class Compiler extends BaseCompiler {
	public function new() {
		super();

		FUN_STD = Macros.importString("std.ml");
	}

	public function makeFun(pair:{key:String, value:BaseBlock}, rec:String):String {
		var newName = makeName(pair.key);
		return '${rec} ${newName} ${separateArray(pair.value.params)} =\n${indent(pair.value.compile(this))}';
	}

	public function blockList(blocks:Map<String, BaseBlock>):String {
		var pairs = [
			for (block in blocks.keyValueIterator())
				block
		];

		var defs = [
			for (i in 0...pairs.length)
				if (i == 0) makeFun(pairs[i], 'let rec') else makeFun(pairs[i], 'and')
		];

		return defs.join("\n\n");
	}

	public function constBlock(consts:Array<String>):String {
		return consts.join("\n");
	}

	public function const(name:String, content:String):String {
		return "let " + name + " = " + content + " in";
	}

	public function outputBlock(exps:Array<Expression>):String {
		var lams = exps.map(function(exp) {
			return "(function () -> (" + exp.compile(this) + "))";
		});
		return "pick_random [|\n" + indent(lams.join(";\n")) + "\n|] ()";
	}

	public function expression(exprs:Array<String>):String {
		return exprs.join(" ^ ");
	}

	public function strToken(str:String):String {
		return "\"" + Utils.escape(str) + "\"";
	}

	public function varToken(str:String):String {
		return str;
	}

	public function blkToken(str:String, params:Array<Expression>):String {
		return '(${makeName(str)} ${separateArray(params.map(param -> param.compile(this)))})';
	}

	private function separateArray(arr:Array<String>) {
		return if (arr.length == 0) '()' else arr.join(' ');
	}
}
