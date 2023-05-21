package textMedley;

#if !js
import haxe.io.Path;
import sys.FileSystem;
import haxe.macro.Context;

using StringTools;

class Compile {
	public static function main() {
		var scripts = readDir('./textMedley', ["textMedley/executable"]);

		var commandLang = "";
		#if (lang == "js")
		commandLang = "-js test/textMedley.js";
		#elseif (lang == "php")
		commandLang = "-php test/php";
		#elseif (lang == "cpp")
		commandLang = "-cpp test/cpp";
		#elseif (lang == "cs")
		commandLang = "-cs test/cs";
		#elseif (lang == "java")
		commandLang = "-java test/java";
		#elseif (lang == "jvm")
		commandLang = "-jvm test/textMedley.jar";
		#elseif (lang == "python")
		commandLang = "-python test/textMedley.py";
		#elseif (lang == "lua")
		commandLang = "-lua test/textMedley.lua";
		#else
		throw 'language not supported';
		#end

		var command = 'haxe -dce no ${commandLang} ${scripts.join(' ')}';
		trace(command);
		Sys.command(command);
	}

	public static function readDir(path:String, excludes:Array<String>):Array<String> {
		var files = FileSystem.readDirectory(path);

		var out = [];

		for (file in files) {
			var truePath = Path.join([path, file]);
			trace(truePath);

			if (excludes.contains(truePath)) {
				continue;
			}

			if (Path.extension(file) == 'hx') {
				out.push(Path.withoutExtension(truePath).replace('/', '.'));
			}

			if (FileSystem.isDirectory(truePath)) {
				var inners = readDir(truePath, excludes);

				for (inner in inners) {
					out.push(inner);
				}
			}
		}

		return out;
	}
}
#end
