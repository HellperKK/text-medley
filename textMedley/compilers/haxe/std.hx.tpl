public static function pick_random(arr : Array<() -> String>) {
    return arr[Std.random(arr.length)];
}

public static function __plus__(num, numBis):String {
    return Std.string(Std.parseFloat(num) + Std.parseFloat(numBis));
}

public static function __minus__(num, numBis):String {
    return Std.string(Std.parseFloat(num) - Std.parseFloat(numBis));
}

public static function __times__(num, numBis):String {
    return Std.string(Std.parseFloat(num) * Std.parseFloat(numBis));
}

public static function __divide__(num, numBis):String {
    return Std.string(Std.parseFloat(num) / Std.parseFloat(numBis));
}

public static function __power__(num, numBis):String {
    return Std.string(Math.pow(Std.parseFloat(num), Std.parseFloat(numBis)));
}

public static function __modulo__(num, numBis):String {
    return Std.string(Std.parseFloat(num) % Std.parseFloat(numBis));
}

public static function __floor__(num):String {
    return Std.string(Math.ffloor(Std.parseFloat(num)));
}

public static function __ceil__(num):String {
    return Std.string(Math.fceil(Std.parseFloat(num)));
}

public static function __clamp__(num, min, max):String {
    var res = Math.min(Std.parseFloat(max), Math.max(Std.parseFloat(min), Std.parseFloat(num)));
    return Std.string(res);
}

public static function __min__(num, numb):String {
    var res = Math.min(Std.parseFloat(num), Std.parseFloat(numb));
    return Std.string(res);
}

public static function __max__(num, numb):String {
    var res = Math.max(Std.parseFloat(num), Std.parseFloat(numb));
    return Std.string(res);
}