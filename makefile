##############___MAKEFILE___################
J_SOURCE=just.maco puts.maco getchar.maco
<<<<<<< HEAD
all: just teste prot just_C
=======
all: just teste
>>>>>>> 5480bc262e1c80098261faca72359da55cc6fef3
#chama o ligador
just: $(J_SOURCE)
	./maclk just.mac $(J_SOURCE)

teste: teste_nao_modularizado.maco
	./maclk teste_nao_modularizado.mac teste_nao_modularizado.maco
#gera o arquivo de código objeto correspondente

<<<<<<< HEAD
prot: prot_just.maco
	./maclk prot_just.mac prot_just.maco

=======
>>>>>>> 5480bc262e1c80098261faca72359da55cc6fef3
just.maco:
	./macas just.as
puts.maco:
	./macas puts.as
getchar.maco:
	./macas getchar.as
teste_nao_modularizado.maco:
	./macas teste_nao_modularizado.as
<<<<<<< HEAD
prot_just.maco:
	./macas prot_just.as
run:
	./macsim teste_nao_modularizado.mac < teste.in
run_prot:
	./macsim prot_just.mac 15 < teste.in
=======
run:
	./macsim teste_nao_modularizado.mac < teste.in
>>>>>>> 5480bc262e1c80098261faca72359da55cc6fef3
clean:
	rm -rf *.maco just.mac teste_nao_modularizado.mac
