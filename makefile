fil = $(wildcard test*.as)
src := $(wildcard *.as)
src := $(filter-out $(fil), $(src))
obj = $(src:.as=.maco)
FILE?=just

all: $(obj)
	./maclk just.mac $(obj)

other: $(FILE).maco
	./maclk $(FILE).mac $^

%.maco: %.as
	./macas $^

%.mac: %.maco
	./maclk $@ $^

clean:
	rm -rf *.maco *.mac
