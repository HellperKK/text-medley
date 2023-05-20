import sys.FileSystem;

class Compile {
	public static var ZIPNAME = 'text-medley.zip';

	public static function main() {
		if (FileSystem.exists(ZIPNAME)) {
			FileSystem.deleteFile(ZIPNAME);
		}

		var out = sys.io.File.write(ZIPNAME, true);
		var zip = new haxe.zip.Writer(out);
		var entries = getEntries("./textMedley");

		var bytes:haxe.io.Bytes = haxe.io.Bytes.ofData(sys.io.File.getBytes("haxelib.json").getData());
		var entry:haxe.zip.Entry = {
			fileName: "haxelib.json",
			fileSize: bytes.length,
			fileTime: Date.now(),
			compressed: false,
			dataSize: sys.FileSystem.stat("haxelib.json").size,
			data: bytes,
			crc32: haxe.crypto.Crc32.make(bytes)
		};

		entries.push(entry);

		zip.write(entries);
	}

	private static function getEntries(dir:String, entries:List<haxe.zip.Entry> = null, inDir:Null<String> = null) {
		if (entries == null)
			entries = new List<haxe.zip.Entry>();
		if (inDir == null)
			inDir = dir;
		for (file in sys.FileSystem.readDirectory(dir)) {
			var path = haxe.io.Path.join([dir, file]);
			if (sys.FileSystem.isDirectory(path)) {
				getEntries(path, entries, inDir);
			} else {
				var bytes:haxe.io.Bytes = haxe.io.Bytes.ofData(sys.io.File.getBytes(path).getData());
				var entry:haxe.zip.Entry = {
					fileName: StringTools.replace(path, inDir, ""),
					fileSize: bytes.length,
					fileTime: Date.now(),
					compressed: false,
					dataSize: sys.FileSystem.stat(path).size,
					data: bytes,
					crc32: haxe.crypto.Crc32.make(bytes)
				};
				entries.push(entry);
			}
		}
		return entries;
	}
}
