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

DataMove_1
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
This section covers data movement:
1. Register - Register
2. Memory - Register
3. Memory - Memory
4. Register - Memory

The topic on accessing the data memory of MSP43FR2433 is also covered in this section. As well as how bytes, low and high-bytes are read/stored. Another is directly adding data to an address, this includes accessing the data memory starting at address 0x002000 and writing to it.

Overall, for the MSP430FR2433, the program memory starts at memory address 0x00C400, the the syntax for data movement is the opcode then the operands. Operands is in the order of source then destination as well as the data flow. It is also capable of register-register, memory-memory, register<>memory, operations. Although you can only write to the specific registers R0-R3 and you are free to do any on the general purpose registers R4-R15 which are all 16-bit.
