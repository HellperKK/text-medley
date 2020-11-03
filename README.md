# Definition

TextMeldey is a language dedicated to text generation. Its core is written in Haxe so it can be used in all contexts that Haxe can target. 

/!\ Since TextMeldey uses regular expressions there may be some tiny differences accross plateforms.

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

You can build TextMeldey using Haxe (up to date) and Make like this

```
make $target
```

where `$target` can be :
- python
- js
- php