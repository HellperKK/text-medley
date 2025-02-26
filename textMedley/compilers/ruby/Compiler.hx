package textMedley.compilers.ruby;

using Lambda;

@:expose
class Compiler extends BaseCompiler {
	private var varNames:Array<String>;

	public function new() {
		super();

		FUN_STD = Macros.importString("std.rb");
		varNames = [];
	}

	public function blockList(blocks:Map<String, BaseBlock>):String {
		var defs = [];

		for (block in blocks.keyValueIterator()) {
			varNames = block.value.params;
			defs.push('def ${makeName(block.key)}(${block.value.params.join(", ")}) \n${indent(block.value.compile(this) + '\nreturn "";')}\nend');
		}

		return defs.join("\n\n");
	}

	public function constBlock(consts:Array<String>):String {
		return consts.join("\n");
	}

	public function const(name:String, content:String):String {
		if (varNames.indexOf(name) == -1) {
			varNames.push(name);

			return '${name}:string = ${content};';
		}

		return '${name} = ${content};';
	}

	public function outputBlock(exps:Array<Expression>):String {
		var weightSum = exps.fold((exp, totalWeight) -> {
			return totalWeight + exp.weight;
		}, 0);

		var acc = 0;

		var lams = exps.mapi((index, exp) -> {
			var phrase = 'if _rand < ${exp.weight + acc} \n${indent("return " + exp.compile(this))}\nend';
			acc += exp.weight;
			return phrase;
		}).join("\n");

		return '_rand = randomNum(${weightSum})\n${lams}';
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
		var params = params.map(param -> param.compile(this)).join(",");
		return '${makeName(str)}(${params})';
	 }
}
