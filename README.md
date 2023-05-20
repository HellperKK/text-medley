# Definition

textMedley is a language dedicated to text generation. Its core is written in Haxe so it can be used in all contexts that Haxe can target. 

/!\ Since textMedley uses regular expressions there may be some tiny differences accross plateforms.

# The language

The language is used to describe a set of rules, each having a set of blocks. Here's a simple example:

```
#main:
    -output:
        hello!
        goodbye!
        woops, I don't know what to say
#end
```

It starts by a `#` followed bien an identifier and finished with the `#end` tag. Here I chose the `main` identifier as it is usally the starting point.

Inside, you find a block named `output`. That block tell the expression that will be returned, which here will be randomly selected between `hello!`, `goodbye!` and `woops, I don't know what to say`. 

The way it works is that the `output` block contains a series of expression, one per non-empty line and returns one randomly. Each expression is left-trimmed so the space before doesn't matter. However, if you want your expression to start with some space you can put it beetween `"` so it it kept from trimming.

You can reference a rule inside exmpression by using its name the same way you declare it. The next example says randomly hello or goodbye to a random name:

```
#main:
    -output:
        hello #name!
        goodbye #name!
#end

#name:
    -output:
        John
        Paul
        world
#end
```

There is not restrictions on rules use and you can event make recursive references.

The last feature is the use on variables. Since referencing a rule always outputs a random result, or when you want to reuse a long expression, you can define variables and use them later, uson the `vars` block, like this:

```
#main:
    -vars:
        $name = #name

    -output:
        hello $name!
        goodbye $name!
        this time it is $name and only $name
#end

#name:
    -output:
        John
        Paul
        world
#end
```

Here on the last output, $name always has the same content.

# Usage

There are two ways of using TextMedley : either with its interpreter or its compiler.

However, in both cases this repository doesn't have any tool to do those. It is only avaliable for anyone to compile it to a target of their choice and then use the result code to build thier own tool.

First you have to instanciate a `BlockList` by giving a string containg the TextMedley source code. This is the base task for any use. For the following examples I will use javascript.

```js
let code = "#main: -output: hello end#"
let blockList = new BlockList(code)
```

## Interpreter

Then you can generate a text using the `eval_main` method

```js
console.log(blockList.eval_main())
```

`eval_main` will assume that your TextMedley code has a block named `main`. You can also use the method `eval` (which `eval_main` is based on) to use the block of your choice as your entry point.

```js
console.log(blockList.eval("main")) //same as calling eval_main()
console.log(blockList.eval("other"))
```

## Compiler

You can also build a compiler to translate TextMedley langage to any programming language that supports all of the following concepts :

- string manipulation
- variables
- functions
- anonymous functions

Those 4 concepts allow for an easy translation. However, there are some languages that don't fit in but should be targted using some work-around. In some way I may suggest that all programming languages are supported, but I'd rather say that I didn't take the time to check them all :)

Anyway, to compile to a language you will need both the BlockList instanciated with the TextMedley source code and an object that tell how to translate it. You can then either use a built-in one among those listed in the `src/compilers` folder or create one yourself. Then you can generate the source code using the `compile` method like this :

```js
let compiler = new compiler.CompilerRuby()
console.log(blockList.compile(compiler)) // prints Ruby code
```
### Create a compiler

TODO

## How to build

You can build textMedley using Haxe (up to date) and Make like this

```
haxe -cp src --main Compile --interp -D lang=$target
```

where `$target` can be :
- js
- php
- cpp
- cs
- java
- jvm
- python
- lua

