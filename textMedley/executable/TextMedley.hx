package textMedley.executable;

import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;

class TextMedley {
	public static function main() {
		var args = Sys.args();
		Shared.run(args);
	}
}
