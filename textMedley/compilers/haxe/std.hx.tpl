static public function pick_random(arr : Array<() -> String>) {
    return arr[Std.random(arr.length)];
}