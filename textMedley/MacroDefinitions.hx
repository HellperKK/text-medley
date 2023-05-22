package textMedley;

class MacroDefinitions {
	public static function condition(cond, ifTrue, ifFalse):String {
		return if (Std.parseFloat(cond) != 0 && cond != "") ifTrue else ifFalse;
	}

	/*
		public static function concat(params:Array<String>):String {
			return params.join("");
		}
	 */
	// functions on numbers
	public static function plus(num, numBis):String {
		return Std.string(Std.parseFloat(num) + Std.parseFloat(numBis));
	}

	public static function minus(num, numBis):String {
		return Std.string(Std.parseFloat(num) - Std.parseFloat(numBis));
	}

	public static function times(num, numBis):String {
		return Std.string(Std.parseFloat(num) * Std.parseFloat(numBis));
	}

	public static function divide(num, numBis):String {
		return Std.string(Std.parseFloat(num) / Std.parseFloat(numBis));
	}

	public static function power(num, numBis):String {
		return Std.string(Math.pow(Std.parseFloat(num), Std.parseFloat(numBis)));
	}

	public static function modulo(num, numBis):String {
		return Std.string(Std.parseFloat(num) % Std.parseFloat(numBis));
	}

	public static function floor(num):String {
		return Std.string(Math.ffloor(Std.parseFloat(num)));
	}

	public static function ceil(num):String {
		return Std.string(Math.fceil(Std.parseFloat(num)));
	}

	public static function clamp(num, min, max):String {
		var res = Math.min(Std.parseFloat(max), Math.max(Std.parseFloat(min), Std.parseFloat(num)));
		return Std.string(res);
	}

	public static function min(num, numb):String {
		var res = Math.min(Std.parseFloat(num), Std.parseFloat(numb));
		return Std.string(res);
	}

	public static function max(num, numb):String {
		var res = Math.max(Std.parseFloat(num), Std.parseFloat(numb));
		return Std.string(res);
	}
}
