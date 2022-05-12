class MasterCompiler {
	public static function main() {
		var ba = "12";
		var be = "42";
		trace(Macros.joinBlocks(ba, be, ba));
	}
}
