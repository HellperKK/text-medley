class Utils {
    @:generic static public function getBlock<T>(inp : String, reg : EReg, func : EReg -> T) {
        var res = [];
        while (reg.match(inp)) {
            res.push(func(reg));
            inp = reg.matchedRight();
        }
        return res;
    }
}