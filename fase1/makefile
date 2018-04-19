##############___MAKEFILE___################

fil = $(wildcard test*.as)
src := $(wildcard *.as)
src := $(filter-out $(fil), $(src))
obj = $(src:.as=.maco)

comp = $(wildcard mac*)

folder=leonardo_ikeda_matheus_conceicao_vitor_serio

FILE?=test

just: $(obj)
	./maclk just.mac $(obj)

other: $(FILE).maco
	./maclk $(FILE).mac $^

tar: $(src) makefile README.md $(comp)
	[ -d $(folder) ] && rm -rf $(folder) || :
	mkdir $(folder)
	cp -t $(folder) $^
	tar -czf $(folder).tar.gz $(folder)

%.maco: %.as
	./macas $^

%.mac: %.maco
	./maclk $@ $^

clean:
	rm -rf *.maco *.mac $(folder)*
