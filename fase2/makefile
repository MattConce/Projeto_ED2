src = $(wildcard *.c)
obj = $(src:.c=.o)

center: $(obj)
	gcc -o $@ $(obj)

clean:
	rm -f *.o
