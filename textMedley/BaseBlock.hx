package textMedley;

import haxe.macro.Expr;
import textMedley.Expression;

using StringTools;

abstract class BaseBlock {
	public var params:Array<String> = [];

	public abstract function eval(blocks:BlockList, params:Array<String>):String;

	public abstract function compile(compiler:textMedley.compilers.BaseCompiler):String;

	public abstract function mustBeCompiled():Bool;

	#if macro
	public abstract function toExpr(blocks:Map<String, BaseBlock>):Function;
	#end
}
