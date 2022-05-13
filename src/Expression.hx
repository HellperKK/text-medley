package;

import Token;
#if macro
import haxe.macro.Expr;
import haxe.macro.Context;
#end

using StringTools;

typedef Capture = {
	var content:Token;
	var next:Int;
}

class Expression {
	public static function evalToken(blocks:BlockList, consts:Map<String, String>, token:Token) {
		return switch (token) {
			case Str(content):
				Utils.escape_interp(content);
			case Var(name):
				consts[name];
			case Blk(name, params):
				blocks.eval(name, params);
		};
	}

	public static function getVar(content:String) {
		var i = 1;

		while (i < content.length && ~/[a-zA-z]/.match(content.charAt(i))) {
			i++;
		}

		return {content: Var(content.substring(1, i)), next: i};
	}

	public static function getBlock(content:String) {
		var i = 1;

		while (i < content.length && ~/[a-zA-z]/.match(content.charAt(i))) {
			i++;
		}

		return {content: Blk(content.substring(1, i), []), next: i};
	}

	public static function getString(content:String) {
		var i = 1;

		while (i < content.length && content.charAt(i) != '"') {
			if (content.charAt(i) == '\\') {
				i++;
			}

			i++;
		}

		if (i == content.length) {
			throw 'missing " for string end';
		}

		return {content: Str(content.substring(1, i)), next: i + 1};
	}

	public static function getEnd(content:String) {
		var i = 1;

		while (i < content.length && ~/[^"$#]/.match(content.charAt(i))) {
			i++;
		}

		return {content: Str(content.substring(0, i)), next: i};
	}

	private var tokens:Array<Token>;

	public function new(content:String) {
		tokens = [];
		var newContent = ~/^\s/.map(content, _e -> "");

		while (newContent != "") {
			var capture:Capture = switch (newContent.charAt(0)) {
				case '"':
					getString(newContent);

				case '$':
					getVar(newContent);

				case '#':
					getBlock(newContent);

				case _: getEnd(newContent);
			}

			tokens.push(capture.content);
			newContent = newContent.substr(capture.next);
		}
	}

	public function eval(blocks:BlockList, consts:Map<String, String>) {
		return [
			for (token in tokens)
				evalToken(blocks, consts, token)
		].join("");
	}

	public function compile(compiler:compilers.BaseCompiler) {
		return compiler.expression([
			for (token in tokens)
				switch (token) {
					case Str(content):
						compiler.strToken(content);
					case Var(name):
						compiler.varToken(name);
					case Blk(name, _params):
						compiler.blkToken(name);
				}
		]);
	}

	public function getTokenNames() {
		return tokens.map(function(token) {
			return switch (token) {
				case Var(name):
					name;
				case _:
					"";
			}
		}).filter(function(name) {
			return name != "";
		});
	}

	#if macro
	public function toExpr():Expr {
		var exprs = tokens.map(token -> {
			switch (token) {
				case Str(content):
					return macro $v{Utils.escape(content)};
				case Var(name): return (macro $i{name});
				case Blk(name, _params):
					return {pos: Context.currentPos(), expr: ECall({pos: Context.currentPos(), expr: EConst(CIdent(name))}, [])};
			}
		});

		var expr = exprs.shift();

		while (exprs.length > 0) {
			expr = macro $expr + ${exprs.shift()};
		}

		return expr;
	}
	#end
}
