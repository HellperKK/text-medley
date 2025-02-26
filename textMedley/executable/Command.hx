package textMedley.executable;

import haxe.io.Path;
import sys.FileStat;
import sys.FileSystem;
import sys.io.File;

class Command {
	public static function main() {
		var args = Sys.args();
		Sys.setCwd(args.pop());
		new mcli.Dispatch(args).dispatch(new Shared());
	}
}
