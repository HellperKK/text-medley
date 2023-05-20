package textMedley.compilers.javascript;

using Lambda;

@:expose
class Compiler extends BaseCompiler {
	private var varNames:Array<String>;

	public function new() {
		super();

		FUN_STD = Macros.importString("std.js");
		varNames = [];
	}

	public function blockList(blocks:Map<String, Block>):String {
		var defs = [];

		for (block in blocks.keyValueIterator()) {
			varNames = block.value.params;
			defs.push('function ${makeName(block.key)}(${block.value.params.join(", ")}) {\n${indent(block.value.compile(this) + '\nthrow new Error("index out of range");')}\n}');
		}

		return defs.join("\n\n");
	}

	public function constBlock(consts:Array<String>):String {
		return consts.join("\n");
	}

	public function const(name:String, content:String):String {
		if (varNames.indexOf(name) == -1) {
			varNames.push(name);

			return 'let ${name} = ${content};';
		}

		return '${name} = ${content};';
	}

	public function outputBlock(exps:Array<Expression>):String {
		var lams = exps.mapi((index, exp) -> {
			return 'if (_rand === ${index}) {\n${indent("return " + exp.compile(this) + ";")}\n}';
			// return "(() => " + exp.compile(this) + ")";
		}).join("\n");
		return 'const _rand = randomNum(${exps.length});\n${lams}';
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
		return makeName(str) + '(${params.map(param -> param.compile(this)).join(",")})';
	}
}
