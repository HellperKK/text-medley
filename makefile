sources := $(shell find -name *.hx)
temp = $(sources:./%.hx=%)
files = $(subst /,.,$(temp))
# files = $(foreach f,$(sources),$(basename $(notdir $(f))))
check := $(shell [ -d ./test ] && echo "true")
dir = $(if $(check),test,.)

php: $(sources)
	haxe -cp . -php $(dir)/output_php $(files)

python: $(sources)
	haxe -cp . -python $(dir)/textMedley.py $(files)

js: $(sources)
	haxe -cp . -js $(dir)/textMedley.js $(files)