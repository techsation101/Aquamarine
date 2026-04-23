puts "Welcome to AMOC"
puts "Please enter your Aquamarine code here:"
puts ""
print ""
code = gets.chomp

def slice_from_nearest_ampersand(array, target_index)
  # Find the last '&' before the target. If nil, use 0.
  start_index = array[0...target_index].rindex('&') || 0

  # Return the slice from that point to the target index
  array[start_index..target_index]
end

#if code.include?("p ")
#  puts "67"
#end

temp0 = ""
temp1 = ""
temp2 = ""
tempArr = []
tempNum0 = 0.0
tempNum1 = 0.0

localInCode = 0

codeAsList = code.chars

variables = {}
variables = Hash.new("Error Missing Variable")

output = ""
outputNum =0.0
#puts codeAsList
for char in codeAsList do
  #print
  if char == "p"
    if localInCode -1 >= 0
      if codeAsList[localInCode - 1] == "&"
        if codeAsList[localInCode + 1] == "`"
          output += "\n"
          for printables in codeAsList[localInCode+2..-1]
            if printables == "`"
              break
            end
            if printables == "\\"
              for variableName in codeAsList[localInCode+3..-1]
                if variableName == "`"
                  break
                end
                temp0 += variableName
              end
              output += variables[temp0].to_s
              break
            end
            output += printables
          end
        end
      end
    elsif localInCode -1 == -1
      if codeAsList[localInCode + 1] == "`"
        output += "\n"
        for printables in codeAsList[localInCode+2..-1]
            if printables == "`"
              break
            end
            if printables == "\\"
              for variableName in codeAsList[localInCode+3..-1]
                if variableName == "`"
                  break
                end
                temp0 += variableName
              end
              output += variables[temp0]
              break
            end
            output += printables
        end
      end
    end
  end
  #variable stuff
  if char == "="
    #if codeAsList[localInCode + 1] != "`"
    #  variables[codeAsList[localInCode - 1]] = codeAsList[localInCode + 1]
    #else
    #  if codeAsList[localInCode + 2] == "n"
    #    variables[codeAsList[localInCode - 1]] = codeAsList[localInCode + 3].to_f
    #  end
    #end
    if codeAsList[localInCode + 1] != "`"
      for value in codeAsList[localInCode+1..-1]
        if value == "&"
          break
        end
        temp1 += value
      end
      tempArr = slice_from_nearest_ampersand(codeAsList, localInCode)
      tempArr.delete("&")
      tempArr.pop
      for value in tempArr
        temp0 += value
      end
      variables[temp0] = temp1
    else
      if codeAsList[localInCode + 2] == "n"
        for value in codeAsList[localInCode+3..-1]
        if value == "&"
          break
        end
        temp1 += value
        end
        tempArr = slice_from_nearest_ampersand(codeAsList, localInCode)
        tempArr.delete("&")
        tempArr.pop
        for value in tempArr
          temp0 += value
        end
        variables[temp0] = temp1.to_f
      end
      if codeAsList[localInCode + 2] == "m"
        for number in codeAsList[localInCode+3..-1]
          if number == "+" || number == "-" || number == "*" || number == "/" || number == "^" 
            break
          end
          temp0 += number
        end
        tempNum0 = temp0.to_f
        for number in codeAsList[localInCode+4+temp0.length..-1]
          if number == "&"
            break
          end
          temp1 += number
        end
        tempArr = slice_from_nearest_ampersand(codeAsList, localInCode)
        tempArr.delete("&")
        tempArr.pop
        for value in tempArr
          temp2 += value
        end
        if codeAsList[localInCode+3+temp0.length] == "+"
          variables[temp2] = temp0.to_f + temp1.to_f
        elsif codeAsList[localInCode+3+temp0.length] == "-"
          variables[temp2] = temp0.to_f - temp1.to_f
        elsif codeAsList[localInCode+3+temp0.length] == "*"
          variables[temp2] = temp0.to_f * temp1.to_f
        elsif codeAsList[localInCode+3+temp0.length] == "/"
          variables[temp2] = temp0.to_f / temp1.to_f
        elsif codeAsList[localInCode+3+temp0.length] == "^"
          variables[temp2] = temp0.to_f ** temp1.to_f
        end
      end
    end
    #puts variables
  end
  temp0 = ""
  temp1 = ""
  temp2 = ""

  localInCode += 1
end

puts ""
puts "Output of code:"
puts output

#puts localInCode