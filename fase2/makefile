src = $(wildcard *.c)
hdr = $(wildcard *.h)
obj = $(src:.c=.o)
folder=leonardo_ikeda_matheus_conceicao_vitor_serio

center: $(obj)
	gcc -o $@ $(obj)

tar: $(src) $(hdr) makefile README.md
	[ -d $(folder) ] && rm -rf $(folder) || :
	mkdir $(folder)
	cp -t $(folder) $^
	tar -czf $(folder).tar.gz $(folder)

clean:
	rm -rf *.o $(folder)*
