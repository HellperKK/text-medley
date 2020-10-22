package src;

import haxe.macro.Context;
import haxe.macro.Expr;
#if macro
import sys.io.File;
#end

class Macros {
    macro public static function importStaticString(name : String, fileName : String):Array<Field> {
        // get existing fields from the context from where build() is called
        var fields = Context.getBuildFields();
        var moduleArr = Context.getLocalClass().get().module.split(".");
        moduleArr.pop();
        var codePath = '${moduleArr.join("/")}/${fileName}';
        
        // append a field
        fields.push({
          name:  name,
          access:  [Access.APublic, Access.AStatic, Access.AInline],
          kind: FieldType.FVar(macro:String, macro $v{File.getContent(codePath)}), 
          pos: Context.currentPos(),
        });
        
        return fields;
      }
}