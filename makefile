sources := $(wildcard src/*.hx)
files = $(foreach f,$(sources),$(basename $(notdir $(f))))
check := $(shell [ -d ./test ] && echo "true")
dir = $(if $(check),test,.)

php:
	haxe -cp src -php $(dir)/output_php $(files)

python: $(sources)
	haxe -cp src -python $(dir)/textMedley.py $(files)