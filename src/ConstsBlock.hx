package;

import compilers.BaseCompiler;

using StringTools;

class ConstsBlock {
	private var defs:Array<{name:String, content:Expression}>;

	public function new(content:String) {
		defs = content.trim().split("\n").filter(line -> line != "").map(line -> {
			var leftPart = ~/\$([a-zA-Z]+)\s*=/;
			var trueLine = Utils.trimRight(line);

			if (!leftPart.match(trueLine)) {
				throw 'invalid const declaration in "${trueLine}"';
			}

			return {name: leftPart.matched(1), content: new Expression(leftPart.matchedRight())};
		});
	}

	public function eval(blocks:BlockList) {
		var res = new Map<String, String>();

		for (def in defs) {
			res.set(def.name, def.content.eval(blocks, res));
		}

		return res;
	}

	public function compile(compiler:BaseCompiler) {
		return compiler.constBlock([
			for (bloc in defs)
				compiler.const(bloc.name, bloc.content.compile(compiler))
		]);
	}
}
