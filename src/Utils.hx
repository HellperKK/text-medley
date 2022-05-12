package;

using StringTools;

class Utils {
	static public function escape_interp(str:String) {
		return str.replace("\\n", "\n");
	}

	static public function escape(str:String) {
		return escape_interp(str).replace("\\", "\\\\").replace("\"", "\\\"");
	}

	static public function trimRight(str:String) {
		return ~/^\s+/.map(str, e -> "");
	}
}
