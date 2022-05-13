package;

#if !js
import haxe.io.Path;
import sys.FileSystem;
import haxe.macro.Context;

using StringTools;

class Compile {
	public static function main() {
		var scripts = readDir('./src');
		var lang = Context.definedValue("lang");

		var commandLang = switch (lang) {
			case "js":
				"-js test/textMedley.js";

			case "php":
				"-php test/php";

			case "cpp":
				"-cpp test/cpp";

			case "cs":
				"-cs test/cs";

			case "java":
				"-java test/java";

			case "jvm":
				"-jvm test/textMedley.jar";

			case "python":
				"-python test/textMedley.py";

			case "lua":
				"-lua test/textMedley.lua";

			case _: throw 'language ${lang} not supported';
		};

		var command = 'haxe -cp src -dce no ${commandLang} ${scripts.join(' ')}';

		trace(command);

		Sys.command(command);
	}

	public static function readDir(path):Array<String> {
		var files = FileSystem.readDirectory(path);

		var out = [];

		for (file in files) {
			var truePath = Path.join([path, file]);

			if (Path.extension(file) == 'hx') {
				out.push(Path.withoutExtension(truePath).replace('/', '.').replace('src.', ''));
			}

			if (FileSystem.isDirectory(truePath)) {
				var inners = readDir(truePath);

				for (inner in inners) {
					out.push(inner);
				}
			}
		}

		return out;
	}
}
#end
