##############___MAKEFILE___################
J_SOURCE=just.maco puts.maco getchar.maco

all: just teste prot just_C
#chama o ligador
just: $(J_SOURCE)
	./maclk just.mac $(J_SOURCE)

teste: teste_nao_modularizado.maco
	./maclk teste_nao_modularizado.mac teste_nao_modularizado.maco
#gera o arquivo de código objeto correspondente

prot: prot_just.maco
	./maclk prot_just.mac prot_just.maco
just.maco:
	./macas just.as
puts.maco:
	./macas puts.as
getchar.maco:
	./macas getchar.as
teste_nao_modularizado.maco:
	./macas teste_nao_modularizado.as
prot_just.maco:
	./macas prot_just.as
run:
	./macsim teste_nao_modularizado.mac < teste.in
run_prot:
	./macsim prot_just.mac 15 < teste.in
run:
	./macsim teste_nao_modularizado.mac < teste.in
clean:
	rm -rf *.maco just.mac teste_nao_modularizado.mac
