package textMedley.compilers.haxe;

using Lambda;

@:expose
class Compiler extends BaseCompiler {
	public function new() {
		super();

		FUN_STD = Macros.importString("std.hx.tpl");
	}

	public override function global(str:String):String {
		var body = super.global(str);

		return 'class TextMedleyGen {\n${indent(body)}\n}';
	}

	public function blockList(blocks:Map<String, BaseBlock>):String {
		return [
			for (block in blocks.keyValueIterator())
				'static public function ${makeName(block.key)}(${block.value.params.join(", ")}) {\n${indent(block.value.compile(this))}\nreturn "";\n}'
		].join("\n\n");
	}

	public function constBlock(consts:Array<String>):String {
		return consts.join("\n");
	}

	public function const(name:String, content:String):String {
		return 'var ${name} = ${content};';
	}

	public function outputBlock(exps:Array<Expression>):String {
		var weightSum = exps.fold((exp, totalWeight) -> {
			return totalWeight + exp.weight;
		}, 0);

		var acc = 0;

		var lams = exps.mapi((index, exp) -> {
			var phrase = 'if (_rand < ${exp.weight + acc}) {\n${indent("return " + exp.compile(this) + ";")}\n}';
			acc += exp.weight;
			return phrase;
		}).join("\n");

		return 'var _rand = Std.random(${weightSum});\n${lams}';
	}

	public function expression(exprs:Array<String>):String {
		return exprs.join(" + ");
	}

	public function strToken(str:String):String {
		return '"${Utils.escape(str)}"';
	}

	public function varToken(str:String):String {
		return str;
	}

	public function blkToken(str:String, params:Array<Expression>):String {
		return '${makeName(str)}(${params.map(param -> param.compile(this)).join(",")})';
	}
}
