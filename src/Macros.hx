package;

import haxe.macro.Context;
import haxe.macro.Expr;
#if macro
import sys.io.File;
import haxe.io.Path;
#end

class Macros {
	macro public static function importString(fileName:String) {
		var posInfos = Context.getPosInfos(Context.currentPos());
		var fileContent = File.getContent(Path.join([Path.directory(posInfos.file), fileName]));

		return macro $v{fileContent};
	}

	macro public static function joinBlocks(exprs:Array<Expr>) {
		var sep = "\n\n";
		var expr = exprs.shift();

		while (exprs.length > 0) {
			expr = macro $expr + $v{sep} + ${exprs.shift()};
		}

		return expr;
	}
}
