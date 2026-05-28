# Aquamarine
A python-based programming language (used to be based on Ruby). Perfect for me.

**Features without +:**

p\`_`(print change _ to what you would like to print)

_=#(set_value change _ to any variable and # to any value (defaults to string))

\\#\\(references_variable change # to any variable)

`m#+#(math change # to any number and + to +, -, *, /, %, or ^ (if used with variable both 'numbers' have to be variables))

`c#+#(string_concatenation change # to any string of characters (if used with variable both 'strings' have to be variables))

`f@#@#@(defining_functions change # to any command, surround commands with @ (must initialize variables outside of function))

f\`#`(calling_functions change # to any function)

RETURN\\#\\(function_return_value change # to any value)

\`f`#(set_value_to_return_of_function change # to any function (recommended you call the function first))

`t(set_value_to_time_in_nanoseconds)

`i(set_value_to_input (it also adds a line down before and two after the input))

l\`#`@\_@_@(while_loop change # to any condition and change _ to any command, surround commands with @ (must initialize variables outside of loop))

T(true_condition)

F(false_condition)

;(break_loop)

?\`#`~\_~_~(if_statement change # to any condition and change _ to any command, surround commands with ~ (must initialize variables outside of if statement))

!~\_~_~(else_statement change _ to any command, surround commands with ~ (same as if))

\\#=_\\(equal_condition change # to any variable and change _ to any variable (no need to surround individual variables with back-slashes))

#+(import_library change # to any library)

**Features inside rand+:**

f\`rand.basic`(sets rand.result equal to a random number between zero and 100)

f\`rand.randNum`(sets rand.result equal to a random number between rand.min and rand.max)