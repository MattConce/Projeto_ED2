src = $(wildcard *.c)
hdr = $(wildcard *.h)
obj = $(src:.c=.o)
folder=leonardo_ikeda_matheus_conceicao_vitor_serio

center: $(obj)
	gcc -Wall -std=c99 -pedantic -O2 -Wextra -o $@ $(obj)

tar: $(src) $(hdr) makefile README.md
	[ -d $(folder) ] && rm -rf $(folder) || :
	mkdir $(folder)
	cp -t $(folder) $^
	tar -cvzf $(folder).tgz $(folder)

clean:
	rm -rf *.o $(folder)*
