package textMedley;

import haxe.macro.Expr;
import textMedley.Expression;

using StringTools;

abstract class BaseBlock {
	public var params:Array<String> = [];

	public abstract function eval(blocks:BlockList, params:Array<Expression>):String;

	public abstract function compile(compiler:textMedley.compilers.BaseCompiler):String;

	#if macro
	public abstract function toExpr():Function;
	#end
}
