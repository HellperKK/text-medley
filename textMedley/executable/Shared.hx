package textMedley.executable;

import sys.io.File;
import haxe.io.Path;
import sys.FileSystem;

class Shared {
	public static function run(args:Array<String>) {
		var cfg = {
			outputPath: null,
			inputPath: null,
			eval: null,
		}
		var argHandler = hxargs.Args.generate([@doc("Set the output path")
			["-o", "--output"] => function(path:String) cfg.outputPath = path, @doc("Set the input path")
			["-i", "--input"] => function(path:String) cfg.inputPath = path,
			@doc("Generates a text with no output")
			["--eval"] => function(name:String) cfg.eval = name,

			_ => function(arg:String) throw "Unknown command: " + arg
		]);

		if (args.length == 0)
			Sys.println(argHandler.getDoc());
		else
			argHandler.parse(args);

		if (cfg.inputPath == null) {
			throw "An input path is mandatory";
		}

		if (!FileSystem.exists(cfg.inputPath)) {
			throw "The input file doesn't exist";
		}

		var code = File.getContent(cfg.inputPath);
		var blockList = new textMedley.BlockList(code);

		if (cfg.eval != null) {
			Sys.println(blockList.eval(cfg.eval));
			Sys.exit(0);
		}

		if (cfg.outputPath == null) {
			throw "An output path is mandatory";
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

		var result = blockList.compile(compiler);
		File.saveContent(cfg.outputPath, result);
	}
}
