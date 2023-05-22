package textMedley.compilers;

using StringTools;

@:expose
abstract class BaseCompiler {
	private var INDENT_STRING = "    ";
	private var FUN_STD = "";

	public function new() {}

	public function indent(code:String) {
		return INDENT_STRING + code.replace('\n', '\n${INDENT_STRING}');
	}

	public function makeName(name:String) {
		return '__${name}__';
	}

	public function global(str:String):String {
		return Macros.joinBlocks(FUN_STD, str);
	}

	abstract public function blockList(blocks:Map<String, BaseBlock>):String;

	abstract public function constBlock(consts:Array<String>):String;

	abstract public function const(name:String, content:String):String;

	abstract public function outputBlock(exps:Array<Expression>):String;

	abstract public function expression(str:Array<String>):String;

	abstract public function strToken(str:String):String;

	abstract public function varToken(str:String):String;

	abstract public function blkToken(str:String, params:Array<Expression>):String;
}
