package textMedley.executable;

import sys.io.File;
import haxe.io.Path;
import sys.FileSystem;

class Shared extends mcli.CommandLine {
	/**
		input code
		@alias i
	**/
	public var input:String;

	/**
		output code
		@alias o
	**/
	public var output:String;

	/**
	 * transpiles the textMeldey code into another
	 */
	public function compile() {
		if (!FileSystem.exists(input)) {
			throw "The input file doesn't exist";
		}

		var code = File.getContent(input);
		var blockList = new textMedley.BlockList(code);

		var extension = Path.extension(output);

		var compiler = switch (extension) {
			case "ts": new textMedley.compilers.typescript.Compiler();
			case "js": new textMedley.compilers.javascript.Compiler();
			case "rb": new textMedley.compilers.ruby.Compiler();
			case "hx": new textMedley.compilers.haxe.Compiler();
			case "ml": new textMedley.compilers.ocaml.Compiler();
			default: throw 'Uknown file extension : ${extension}';
		}

		var result = blockList.compile(compiler);
		File.saveContent(output, result);
	}
}
