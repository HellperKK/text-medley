package textMedley;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
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

	#if macro
	public static function codify(path:String) {
		var fields = Context.getBuildFields();

		var code = File.getContent(path);
		var blockList = new BlockList(code);

		for (expr in blockList.toExpr()) {
			fields.push(expr);
		}

		return fields;
	}
	#end
}
