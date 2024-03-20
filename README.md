# MSP430-ASM-DATA
First chapter of my journey on MSP430:
This chapter is learning about the addressing modes and the way to move 
data from register-register and register-memory vise versa.

Relevance:
Learning these would help me process sensor data, for example, reading a data from a port connected to a sensor
then sending that data to another port or store them into memory.

Objective:
I should be able to move and copy data from register-register or memory-register, as well as memory-memory
at the end of this chapter.

Data_Types
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
This section simply explores as to how some information are stored in the memory.
1. Strings are simply stored in consecutive ASCII representations of the characters.
2. Fractional numbers, signed and unsigned, which are necessary when dealing with real-word measurements and even calculations, are stored in the IEEE 754 32-bit format. Consisting of the sign bit (0+, 1-) then the bias which is 8-bits then the exponent, all amount to the 32-bits. It is stored first with the least significant bits and then per byte. Another important note is numbers like 0.025 are not accurately represented as exactly 0.025, there are errors, for example, converting back the stored 4-byte IEEE 754 to decimal of the 0.025 is 0.02500000037252902984619140625, a heads up in case precision is very important.
3. Integers or any number except when defined as .float, are stored in their direct binary format or hex, negatives are in two's complement. The .int can't accept fractional numbers, unlike higher level languages, do not automatically round to the integer.
4. Characters are also stored in their ASCII format.

DataMove_1
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
This section covers data movement:
1. Register - Register
2. Memory - Register
3. Memory - Memory
4. Register - Memory

The topic on accessing the data memory of MSP43FR2433 is also covered in this section. As well as how bytes, low and high-bytes are read/stored. Another is directly adding data to an address, this includes accessing the data memory starting at address 0x002000 and writing to it.

Overall, for the MSP430FR2433, the program memory starts at memory address 0x00C400, the the syntax for data movement is the opcode then the operands. Operands is in the order of source then destination as well as the data flow. It is also capable of register-register, memory-memory, register<>memory, operations. Although you can only write to the specific registers R0-R3 and you are free to do any on the general purpose registers R4-R15 which are all 16-bit.

DataMove_2
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
This section covers data movement using symbolic addressing as well as an introduction to indirect addressing.
1. Symbolic addressing is very important since it is the equivalent of the way we define variables at higher level programming languages such as C-language, where for example, we define a variable as say, var1=255, from then on, we can refer to that variable as var1. This again useful as in much more complex programs in which there are many variables to keep track of, it is easy to address them this way instead of using their actual memory address or their value itself (which is not useful if the value itself is changing or not constant).
2. For the indirect addressing, this is about storing an address as a value to a register. As to how is this useful, this is so that we can use the address in that register and increment it. By using the stored address, we can dynamically move from that address and access neighboring addresses. This is useful as in the case of blocks of data say, a section of memory is reserved to a sensor's data, we need to only know where we set the beginning of the data for that sensor in the memory address and store it to a register and then increment it from then on as we like to access the data and copy/store it somewhere else, instead of directly typing the addresses themselves which can be tedious and most of all, results to more sources of error, as there could be a typo in writting the addresses which results to wrong data copied or memory addressed.

DataMove_3
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
This section extends the concept from indirect addressing, the indirect addressing from DataMove_2 seems to only cover the moving of the pointed address in an increasing manner from the the address my an increment of one.
1. The extended indirect addressing in this section is the same as storing an address to a register and using it as a reference, but the only difference is that we can now define the number of steps we move from the the reference address in the register we used. This is useful as sometimes we only want to look into a specific section of the block of data we might be interested in, so moving a specific number of steps reduces the amount of instructions tht needed to be done just to move to a specific point in memory.
2. This is also the part where word access and byte access makes a lot of difference. Word access treats the source and destinations as words so the values are taken as 2-bytes in the case of 16-bits with the high-byte looked/pointed nto first then while for byte access it is per-byte with the low-byte of a 16-bit data is seen or pointed to first.
