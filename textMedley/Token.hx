package textMedley;

import textMedley.Expression;

enum Token {
	Str(content:String);
	Var(name:String);
	Blk(name:String, params:Array<Expression>);
}
