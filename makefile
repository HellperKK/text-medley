sources := $(shell find -name *.hx)
temp = $(sources:./%.hx=%)
files = $(subst /,.,$(temp))
# files = $(foreach f,$(sources),$(basename $(notdir $(f))))
check := $(shell [ -d ./test ] && echo "true")
dir = $(if $(check),test,.)

php: $(sources)
	haxe -cp src -php $(dir)/output_php $(files)

python: $(sources)
	haxe -cp src -python $(dir)/textMedley.py $(files)

js: $(sources)
	haxe -cp src -js $(dir)/textMedley.js $(files)