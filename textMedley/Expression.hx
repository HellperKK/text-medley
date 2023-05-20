package textMedley;

import textMedley.Token;
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

	public static function getBlock(content:String):Capture {
		var i = 1;

		while (i < content.length && ~/[a-zA-z]/.match(content.charAt(i))) {
			i++;
		}

		var name = content.substring(1, i);
		var res = [];

		if (content.charAt(i) == "(") {
			var parse = parseBlock(content.substring(i));
			i += parse.size;
			res = parse.res;
		}

		return {content: Blk(name, res), next: i};
	}

	public static function parseBlock(content:String) {
		var i = 1;
		var lastI = 1;
		var res = [];

		while (content.charAt(i) != ")" && i < content.length) {
			i += switch (content.charAt(i)) {
				case '"':
					getString(content.substring(i)).length;

				case ',':
					res.push(new Expression(content.substring(lastI, i)));
					lastI = i + 1;
					1;

				case "$": getVar(content.substring(i)).next;
				case "#": getBlock(content.substring(i)).next;
				case _: 1;
			};
		}

		res.push(new Expression(content.substring(lastI, i)));

		return {size: i, res: res};
	}

	public static function getString(content:String) {
		var i = 1;

		while (i < content.length && content.charAt(i) != '"') {
			trace(content.charAt(i));
			if (content.charAt(i) == '\\') {
				i++;
			}

			i++;
		}

		if (i == content.length) {
			throw 'missing " for string end';
		}

		return content.substring(1, i);
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
		var newContent = content.ltrim();

		if (newContent.charAt(0) == '"') {
			newContent = getString(newContent);
		} else {
			newContent = newContent.rtrim();
		}

		while (newContent != "") {
			var capture:Capture = switch (newContent.charAt(0)) {
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

	public function compile(compiler:textMedley.compilers.BaseCompiler) {
		return compiler.expression([
			for (token in tokens)
				switch (token) {
					case Str(content):
						compiler.strToken(content);
					case Var(name):
						compiler.varToken(name);
					case Blk(name, params):
						compiler.blkToken(name, params);
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
				case Blk(name, params):
					var paramsExpr = params.map(param -> param.toExpr());
					return {
						pos: Context.currentPos(),
						expr: ECall({
							pos: Context.currentPos(),
							expr: EConst(CIdent(name))
						}, paramsExpr)
					};
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
