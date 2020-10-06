array: array.o
	ld -o array array.o

array.o: array.s
	as -o array.o array.s

clean:
	rm *.o array

debug:
	as -g -o array.o array.s
	ld -o array array.o
	gdb array
