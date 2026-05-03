#!/usr/bin/env python3
import collections
import sys

print("Welcome to AMOC")
print("Please enter your Aquamarine code here:\n")
if len(sys.argv) > 1:
    # Grab the first argument after the script name
    file_path = sys.argv[1] 
    
    with open(file_path, 'r') as file:
        content = file.read()
    #print("File content:")
    code = content
else:
    code = input("")

# Helper function to find the nearest ampersand
def slice_from_nearest_ampersand(char_list, target_index):
    # Search backwards for '&'
    start_index = 0
    for i in range(target_index - 1, -1, -1):
        if char_list[i] == '&':
            start_index = i
            break
    return char_list[start_index : target_index + 1]

# Helper for variable referencing (logic mirrored from variable_referencer)
def variable_referencer(index_ahead, char_list, local, variables_dict):
    temp = ""
    start_pos = local + index_ahead
    for char in char_list[start_pos:]:
        if char == "\\":
            break
        temp += char
    
    # Python dict handles missing keys slightly differently than Ruby's default Hash
    return variables_dict.get(temp, "Error Missing Variable"), temp

# Setup variables
variables = {}
output = ""
code_as_list = list(code)
local_in_code = 0

for char in code_as_list:
    # --- PRINTING LOGIC (p command) ---
    if char == "p":
        should_print = False
        # Ruby logic: if index-1 >= 0 and code[index-1] == '&'
        if local_in_code - 1 >= 0:
            if code_as_list[local_in_code - 1] == "&" and code_as_list[local_in_code + 1] == "`":
                should_print = True
        elif local_in_code == 0:
            if len(code_as_list) > 1 and code_as_list[1] == "`":
                should_print = True
        
        if should_print:
            output += "\n"
            # Iterate through the printable section
            for i in range(local_in_code + 2, len(code_as_list)):
                p_char = code_as_list[i]
                if p_char == "`":
                    break
                if p_char == "\\":
                    val, _ = variable_referencer(3, code_as_list, local_in_code, variables)
                    output += str(val)
                    break
                output += p_char

    # --- VARIABLE ASSIGNMENT LOGIC (= command) ---
    if char == "=":
        temp0 = ""
        temp1 = ""
        
        # Simple Assignment
        if code_as_list[local_in_code + 1] != "`":
            for i in range(local_in_code + 1, len(code_as_list)):
                val = code_as_list[i]
                if val == "&":
                    break
                temp1 += val
            
            temp_arr = slice_from_nearest_ampersand(code_as_list, local_in_code)
            # Remove '&' and '=' (pop equivalent)
            temp_arr = [c for c in temp_arr if c != "&"]
            if temp_arr: temp_arr.pop() 
            
            var_name = "".join(temp_arr)
            variables[var_name] = temp1
            
        # Math/Complex Assignment
        else:
            if code_as_list[local_in_code + 2] == "m":
                perm0 = ""
                temp3 = ""
                temp5_str = ""
                
                # Parse first number or variable
                for i in range(local_in_code + 3, len(code_as_list)):
                    num_char = code_as_list[i]
                    if num_char in ["+", "-", "*", "/", "^"]:
                        break
                    if num_char == "\\":
                        val, temp5_str = variable_referencer(4, code_as_list, local_in_code, variables)
                        perm0 = str(val)
                        break
                    perm0 += num_char
                
                num0 = float(perm0) if perm0 else 0.0
                
                # Parse second number or variable
                temp4 = ""
                for i in range(local_in_code + 4 + len(perm0), len(code_as_list)):
                    num_char = code_as_list[i]
                    if num_char == "&":
                        break
                    if num_char == "\\":
                        val, _ = variable_referencer(7 + len(temp5_str), code_as_list, local_in_code, variables)
                        temp1 = str(val)
                        break
                    temp1 += num_char
                
                # Get target variable name
                temp_arr = slice_from_nearest_ampersand(code_as_list, local_in_code)
                temp_arr = [c for c in temp_arr if c != "&"]
                if temp_arr: temp_arr.pop()
                target_var = "".join(temp_arr)
                
                # Perform Math
                num1 = float(temp1) if temp1 else 0.0
                op_index = local_in_code + 5 + len(temp5_str)
                # Check for operator bounds
                if op_index < len(code_as_list):
                    op = code_as_list[op_index]
                    if op == "+": variables[target_var] = num0 + num1
                    elif op == "-": variables[target_var] = num0 - num1
                    elif op == "*": variables[target_var] = num0 * num1
                    elif op == "/": variables[target_var] = num0 / num1 if num1 != 0 else 0
                    elif op == "^": variables[target_var] = num0 ** num1

    local_in_code += 1

print("\nOutput of code:")
print(output)