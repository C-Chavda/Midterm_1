#Author: Chandresh Chavda
#Author email: chav349@csu.fullerton.edu
#CWID: 885158899
#Class: 240-11 Section 11
#Date: March 11, 2025

#Delete some un-needed files
rm *.o
rm *.out

nasm -f elf64 -l electric.lis -o electric.o electricity.asm

nasm -f elf64 -l current.lis -o current.o current.asm

nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

gcc  -m64 -Wall -no-pie -o main.o -std=c2x -c main.c

gcc -m64 -no-pie -o circuit.out electric.o current.o isfloat.o main.o -std=c2x -Wall -z noexecstack -lm

chmod +x circuit.out
./circuit.out

echo "This bash script will now terminate."