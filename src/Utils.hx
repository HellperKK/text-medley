package;

using StringTools;

class Utils {
	@:generic static public function getBlock<T>(inp:String, reg:EReg, func:EReg->T) {
		var res = [];
		while (reg.match(inp)) {
			res.push(func(reg));
			inp = reg.matchedRight();
		}
		return res;
	}

	@:generic static public function arrayUniq<T>(elems:Array<T>) {
		var res = [];
		for (elem in elems) {
			if (res.indexOf(elem) == -1) {
				res.push(elem);
			}
		}
		return res;
	}

	static public function escape_interp(str:String) {
		return str.replace("\\n", "\n");
	}

	static public function escape(str:String) {
		return escape_interp(str).replace("\\", "\\\\").replace("\"", "\\\"");
	}

	static public function moduleToPath(module:String) {
		return module.replace(".", "/");
	}

	static public function warning(text:String) {
		trace('WARNING! ${text}');
	}

	static public function getVars(str:String) {
		if (Type.getClass(str) == String) {
			return str.split(',').map(str -> {
				var reg = ~/\$([a-zA-Z]+)/;

				if (reg.match(str)) {
					return reg.matched(1);
				}

				return "";
			});
		}

		return [];
	}

	static public function safeSplit(str:String, sep:String) {
		if (Type.getClass(str) == String) {
			return str.split(sep);
		}

		return [];
	}
}
