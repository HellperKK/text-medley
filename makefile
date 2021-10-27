sources := $(wildcard src/**.hx)
temp = $(sources:./%.hx=%)
files = $(subst /,.,$(subst src/,,$(temp)))
# files = $(foreach f,$(sources),$(basename $(notdir $(f))))
# check := $(shell [ -d ./test ] && echo "true")
dir = test#$(if $(check),test,.)

js: $(sources)
	haxe -cp src -js $(dir)/textMedley.js $(files)

php: $(sources)
	haxe -cp src -php $(dir)/output_php $(files)

python: $(sources)
	haxe -cp src -python $(dir)/textMedley.py $(files)