##############___MAKEFILE___################

all: just
#chama o ligador
just: just.maco puts.maco getchar.maco
	./maclk just.mac just.maco puts.maco getchar.maco

#gera o arquivo de código objeto correspondente
just.maco:
	./macas just.as
puts.maco:
	./macas puts.as
getchar.maco:
	./macas getchar.as

clean:
	rm -rf *.maco
