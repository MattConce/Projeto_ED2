##############___MAKEFILE___################

fil = $(wildcard test*.as)
src := $(wildcard *.as)
src := $(filter-out $(fil), $(src))
obj = $(src:.as=.maco)
FILE?=main

all: $(obj)
	./maclk main.mac $(obj)

other: $(FILE).maco
	./maclk $(FILE).mac $^

%.maco: %.as
	./macas $^

%.mac: %.maco
	./maclk $@ $^

clean:
	rm -rf *.maco *.mac
