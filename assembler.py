import tkinter as tk
from tkinter import messagebox
from tkinter import scrolledtext
from tkinter import ttk

def bin_format(val, bits):
    return format(val, 'b').zfill(bits)

def r_type(inst, fnc, rs1, rd, rs2, stop):
    return fnc + bin_format(rs1, 5) + bin_format(rd, 5) + bin_format(rs2, 5) + "0"*9 + "00" + "0"

def i_type(inst, fnc, rs1, rd, imm, stop):
    return fnc + bin_format(rs1, 5) + bin_format(rd, 5) + bin_format(imm, 14) + "10" + "0"

def j_type(inst, fnc, imm, stop):
    return fnc + bin_format(imm, 24) + "01" + "0"

def s_type(inst, fnc, rs1, rd, rs2, sa, stop):
    return fnc + bin_format(rs1, 5) + bin_format(rd, 5) + bin_format(rs2, 5) + bin_format(sa, 5) + "0"*4 + "11" +"0"

def bin_to_hex(bin_str):
    return format(int(bin_str, 2), 'x').zfill(8)

instr_dict = {
    "and":  ["00000", r_type],
    "add":  ["00001", r_type],
    "sub":  ["00010", r_type],
    "cmp":  ["00011", r_type],
    "andi": ["00000", i_type],
    "addi": ["00001", i_type],
    "lw":   ["00010", i_type],
    "sw":   ["00011", i_type],
    "beq":  ["00100", i_type],
    "j":    ["00000", j_type],
    "jal":  ["00001", j_type],
    "sll":  ["00000", s_type],
    "slr":  ["00001", s_type],
    "sllv": ["00010", s_type],
    "slrv": ["00011", s_type]
}

def assemble(instruction):
    parts = instruction.split()

    for i in range(1, len(parts)):
        if "$" in parts[i]:
            parts[i] = parts[i].replace("$", "")

    inst = parts[0]
    fnc, instr_type = instr_dict[inst]

    if instr_type == r_type:
        return bin_to_hex(instr_type(inst, fnc, int(parts[1]), int(parts[2]), int(parts[3]), "0"))
    elif instr_type == i_type:
        return bin_to_hex(instr_type(inst, fnc, int(parts[1]), int(parts[2]), int(parts[3]), "0"))
    elif instr_type == j_type:
        return bin_to_hex(instr_type(inst, fnc, int(parts[1]), "0"))
    elif instr_type == s_type:
        return bin_to_hex(instr_type(inst, fnc, int(parts[1]), int(parts[2]), int(parts[3]), int(parts[4]), "0"))

window = tk.Tk()
window.title("Assembler GUI")

style = ttk.Style()
style.theme_use('clam')  

top_frame = ttk.Frame(window)
top_frame.pack(side=tk.TOP, pady=20)

middle_frame = ttk.Frame(window)
middle_frame.pack(side=tk.TOP, pady=20)

bottom_frame = ttk.Frame(window)
bottom_frame.pack(side=tk.TOP, pady=20)

label = ttk.Label(top_frame, text="Enter an assembly instruction:")
label.pack()

input_field = ttk.Entry(top_frame, width=50)
input_field.pack()

output_area = scrolledtext.ScrolledText(middle_frame, width=40, height=10)
output_area.pack()

def assemble_and_display():
    instruction = input_field.get()
    try:
        result = assemble(instruction)
        output_area.insert(tk.END, f'{instruction} : {result}\n')
    except Exception as e:
        messagebox.showerror("Error", f"Error assembling instruction: {e}")

submit_button = ttk.Button(bottom_frame, text="Assemble", command=assemble_and_display)
submit_button.pack()

window.mainloop()

