asm_filename = input("Enter assembly program filename: ").strip()
asm = open(asm_filename, "r")
instruction_file = open("init_mem.data", 'w')

opcodes = {
    "add": "000000",
    "sub": "000000",
    "and": "000000",
    "or" : "000000",
    "slt": "000000",
    "lw" : "100011",
    "sw" : "101011",
    "beq": "000100",
    "addi": "001000",
    "j": "000010"
}

functs = {
    "add": "100000",
    "sub": "100010",
    "and": "100100",
    "or" : "100101",
    "slt": "101010"
}

# Register name to number map
registers = {
    "$zero": 0, "$at": 1, "$v0": 2, "$v1": 3,
    "$a0": 4, "$a1": 5, "$a2": 6, "$a3": 7,
    "$t0": 8, "$t1": 9, "$t2": 10, "$t3": 11,
    "$t4": 12, "$t5": 13, "$t6": 14, "$t7": 15,
    "$s0": 16, "$s1": 17, "$s2": 18, "$s3": 19,
    "$s4": 20, "$s5": 21, "$s6": 22, "$s7": 23,
    "$t8": 24, "$t9": 25, "$k0": 26, "$k1": 27,
    "$gp": 28, "$sp": 29, "$fp": 30, "$ra": 31
}

def reg_to_5bit(reg):
    return "{:05b}".format(registers[reg])

def int_to_16bit(value):
    value = int(value)
    if value < 0:
        value = (1 << 16) + value  # two's complement
    return "{:016b}".format(value)

def int_to_26bit(value):
    return "{:026b}".format(int(value))

instructions = asm.readlines()
for instr in instructions:
    instr = instr.strip()
    if instr == "" or instr.startswith("#"):
        continue

    instr = instr.replace(',', ' ').replace('(', ' ').replace(')', ' ').split()
    instr[0] = instr[0].lower()

    binary_instr = opcodes[instr[0]]

    if instr[0] in functs:  # R-type
        binary_instr += reg_to_5bit(instr[2])  # rs
        binary_instr += reg_to_5bit(instr[3])  # rt
        binary_instr += reg_to_5bit(instr[1])  # rd
        binary_instr += "00000"                # shamt
        binary_instr += functs[instr[0]]       # funct

    elif instr[0] in ["lw", "sw"]:  # I-type memory
        binary_instr += reg_to_5bit(instr[3])  # base
        binary_instr += reg_to_5bit(instr[1])  # rt
        binary_instr += int_to_16bit(instr[2]) # offset

    elif instr[0] in ["addi"]:  # I-type add immediate
        binary_instr += reg_to_5bit(instr[2])  # rs
        binary_instr += reg_to_5bit(instr[1])  # rt
        binary_instr += int_to_16bit(instr[3]) # immediate

    elif instr[0] == "beq":  # I-type branch
        binary_instr += reg_to_5bit(instr[1])  # rs
        binary_instr += reg_to_5bit(instr[2])  # rt
        binary_instr += int_to_16bit(instr[3]) # offset

    elif instr[0] == "j":  # J-type jump
        binary_instr += int_to_26bit(instr[1])

    instruction_file.write(binary_instr + "\n")
    print(binary_instr)

asm.close()
instruction_file.close()
