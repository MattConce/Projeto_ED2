<<<<<<< Updated upstream
fil = $(wildcard test*.as)
src := $(wildcard *.as)
src := $(filter-out $(fil), $(src))
obj = $(src:.as=.maco)
FILE?=just
=======
##############___MAKEFILE___################
J_SOURCE=just.maco puts.maco readParagraph.maco read.maco breakInWords.maco breakInLines.maco insertChar.maco formatLine.maco
all: just teste
#chama o ligador
just: $(J_SOURCE)
	./maclk just.mac $(J_SOURCE)
>>>>>>> Stashed changes

all: $(obj)
	./maclk just.mac $(obj)

other: $(FILE).maco
	./maclk $(FILE).mac $^

%.maco: %.as
	./macas $^

%.mac: %.maco
	./maclk $@ $^

<<<<<<< Updated upstream
=======
just.maco:
	./macas just.as
puts.maco:
	./macas puts.as
read.maco:
	./macas read.as
breakInLines.maco:
	./macas breakInLines.as
breakInWords.maco:
	./macas breakInWords.as
formatLine.maco:
	./macas formatLine.as
insertChar.maco:
	./macas insertCha.as
atoi.maco:
	./macas atoi.as
readParagraph.maco:
	./macas readParagraph.as

teste_nao_modularizado.maco:
	./macas teste_nao_modularizado.as
run:
	./macsim teste_nao_modularizado.mac < teste.in
>>>>>>> Stashed changes
clean:
	rm -rf *.maco *.mac
