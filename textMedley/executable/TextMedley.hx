package textMedley.executable;

import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;

class TextMedley {
	public static function main() {
		var cfg = {
			outputPath: null,
			inputPath: null
		}
		var argHandler = hxargs.Args.generate([@doc("Set the output path")
			["-o", "--output"] => function(path:String) cfg.outputPath = path, @doc("Set the input path")
			["-i", "--input"] => function(path:String) cfg.inputPath = path,

			_ => function(arg:String) throw "Unknown command: " + arg
		]);

		var args = Sys.args();

		if (args.length == 0)
			Sys.println(argHandler.getDoc());
		else
			argHandler.parse(args);

		if (cfg.outputPath == null) {
			Sys.println("An output path is mandatory");
			Sys.exit(0);
		}

		if (cfg.inputPath == null) {
			Sys.println("An input path is mandatory");
			Sys.exit(0);
		}

		if (!FileSystem.exists(cfg.inputPath)) {
			Sys.println("The input file doesn't exist");
			Sys.exit(0);
		}

		var extension = Path.extension(cfg.outputPath);

		var compiler = switch (extension) {
			case "ts": new textMedley.compilers.typescript.Compiler();
			case "js": new textMedley.compilers.javascript.Compiler();
			case "rb": new textMedley.compilers.ruby.Compiler();
			case "hx": new textMedley.compilers.haxe.Compiler();
			case "ml": new textMedley.compilers.ocaml.Compiler();
			default: throw 'Uknown file extension : ${extension}';
		}

		var code = File.getContent(cfg.inputPath);
		var blockList = new textMedley.BlockList(code);
		var result = blockList.compile(compiler);
		File.saveContent(cfg.outputPath, result);
	}
}
