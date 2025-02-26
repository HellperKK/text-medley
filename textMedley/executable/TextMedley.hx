package textMedley.executable;

import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;

class TextMedley {
	public static function main() {
		new mcli.Dispatch(Sys.args()).dispatch(new Shared());
	}
}
