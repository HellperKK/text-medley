package textMedley;

class Definitions {
	public static function condition(params:Array<String>):String {
		return switch (params) {
			case [cond, ifTrue, ifFalse]:
				if (Std.parseFloat(cond) != 0 && cond != "") ifTrue else ifFalse;
			case _:
				throw "wrong param number in if function";
		};
	}

	public static function concat(params:Array<String>):String {
		return switch (params) {
			case [val, valb]:
				val + valb;
			case _:
				throw "wrong param number in if function";
		};
	}

	// functions on numbers
	public static function plus(params:Array<String>):String {
		return switch (params) {
			case [num, numBis]:
				Std.string(Std.parseFloat(num) + Std.parseFloat(numBis));
			case _:
				throw "wrong param number in plus function";
		};
	}

	public static function minus(params:Array<String>):String {
		return switch (params) {
			case [num, numBis]:
				Std.string(Std.parseFloat(num) - Std.parseFloat(numBis));
			case _:
				throw "wrong param number in minus function";
		};
	}

	public static function times(params:Array<String>):String {
		return switch (params) {
			case [num, numBis]:
				Std.string(Std.parseFloat(num) * Std.parseFloat(numBis));
			case _:
				throw "wrong param number in times function";
		};
	}

	public static function divide(params:Array<String>):String {
		return switch (params) {
			case [num, numBis]:
				Std.string(Std.parseFloat(num) / Std.parseFloat(numBis));
			case _:
				throw "wrong param number in divide function";
		};
	}

	public static function power(params:Array<String>):String {
		return switch (params) {
			case [num, numBis]:
				Std.string(Math.pow(Std.parseFloat(num), Std.parseFloat(numBis)));
			case _:
				throw "wrong param number in power function";
		};
	}

	public static function modulo(params:Array<String>):String {
		return switch (params) {
			case [num, numBis]:
				Std.string(Std.parseFloat(num) % Std.parseFloat(numBis));
			case _:
				throw "wrong param number in modulo function";
		};
	}

	public static function floor(params:Array<String>):String {
		return switch (params) {
			case [num]:
				Std.string(Math.ffloor(Std.parseFloat(num)));
			case _:
				throw "wrong param number in floor function";
		};
	}

	public static function ceil(params:Array<String>):String {
		return switch (params) {
			case [num]:
				Std.string(Math.fceil(Std.parseFloat(num)));
			case _:
				throw "wrong param number in ceil function";
		};
	}

	public static function clamp(params:Array<String>):String {
		return switch (params) {
			case [num, min, max]:
				var res = Math.min(Std.parseFloat(max), Math.max(Std.parseFloat(min), Std.parseFloat(num)));
				Std.string(res);
			case _:
				throw "wrong param number in clamp function";
		};
	}

	public static function min(params:Array<String>):String {
		return switch (params) {
			case [num, numb]:
				var res = Math.min(Std.parseFloat(num), Std.parseFloat(numb));
				Std.string(res);
			case _:
				throw "wrong param number in min function";
		};
	}

	public static function max(params:Array<String>):String {
		return switch (params) {
			case [num, numb]:
				var res = Math.max(Std.parseFloat(num), Std.parseFloat(numb));
				Std.string(res);
			case _:
				throw "wrong param number in max function";
		};
	}
}
