package src;

enum Token {
    Str(content: String);
    Var(name: String);
    Blk(name: String);
}