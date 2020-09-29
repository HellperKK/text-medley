using StringTools;

class Test {
    static public function hello() {
        trace("Hello world");
    }

    static public function ptest(inp : String) {
        var sepreg = ~/\n\n+/g;
        var blocreg = ~/^\w+:\s*(\s-vars:[^\-]*)?\s+-output:.*$/m;
        var blocs = sepreg.split(inp);
        return blocs.map(function(bloc) {
            return bloc.trim();
        }).filter(function(bloc) {
            return (bloc != "") && blocreg.match(bloc);
        });
    }
}