#!/usr/bin/env ruby

puts "Welcome to AMOC"
puts "Please enter your Aquamarine code here:"
puts ""
print ""
code = gets.chomp
#code = File.read(filename)

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
temp3 = ""
temp4 = ""
temp5 = ""
tempArr = []
tempNum0 = 0.0
tempNum1 = 0.0

perm0 = ""

localInCode = 0

codeAsList = code.chars

variables = {}
variables = Hash.new("Error Missing Variable")

output = ""
outputNum =0.0

def variable_referencer(index_ahead, list, local, temp, variablesList, otherTemp = nil)
  for variableName in list[local+index_ahead..-1]
    if variableName == "\\"
      break
    end
    temp += variableName
    #puts temp
  end
  if otherTemp != nil
    otherTemp << temp
  end
  variablesList[temp]
end

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
              output += variable_referencer(3, codeAsList, localInCode, temp0, variables).to_s
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
              output += variable_referencer(3, codeAsList, localInCode, temp0, variables).to_s
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
      if codeAsList[localInCode + 2] == "m"
        for number in codeAsList[localInCode+3..-1]
          if number == "+" || number == "-" || number == "*" || number == "/" || number == "^" 
            break
          end
          if number == "\\"
            perm0 += variable_referencer(4, codeAsList, localInCode, temp3, variables, temp5)
            #puts temp0
            #puts temp5
            break
          end
          perm0 += number
        end
        tempNum0 = perm0.to_f
        for number in codeAsList[localInCode+4+perm0.length..-1]
          if number == "&"
            break
          end
          if number == "\\"
            temp1 = ""
            temp1 += variable_referencer(7+temp5.length, codeAsList, localInCode, temp4, variables)
            #puts temp1
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
        #puts temp2
        #puts variable_referencer(4+temp0.length, codeAsList, localInCode, temp3, variables)
        if codeAsList[localInCode+5+temp5.length] == "+"
          variables[temp2] = perm0.to_f + temp1.to_f
        elsif codeAsList[localInCode+5+temp5.length] == "-"
          variables[temp2] = perm0.to_f - temp1.to_f
        elsif codeAsList[localInCode+5+temp5.length] == "*"
          variables[temp2] = perm0.to_f * temp1.to_f
        elsif codeAsList[localInCode+5+temp5.length] == "/"
          variables[temp2] = perm0.to_f / temp1.to_f
        elsif codeAsList[localInCode+5+temp5.length] == "^"
          variables[temp2] = perm0.to_f ** temp1.to_f
        end
        perm0 = ""
        #puts perm0.to_f + temp1.to_f
        if codeAsList[localInCode+3+perm0.length] == "+"
          variables[temp2] = perm0.to_f + temp1.to_f
        elsif codeAsList[localInCode+3+perm0.length] == "-"
          variables[temp2] = perm0.to_f - temp1.to_f
        elsif codeAsList[localInCode+3+perm0.length] == "*"
          variables[temp2] = perm0.to_f * temp1.to_f
        elsif codeAsList[localInCode+3+perm0.length] == "/"
          variables[temp2] = perm0.to_f / temp1.to_f
        elsif codeAsList[localInCode+3+perm0.length] == "^"
          variables[temp2] = perm0.to_f ** temp1.to_f
        end
      end
    end
    #puts variables
  end
  temp0 = ""
  temp1 = ""
  temp2 = ""
  temp3 = ""
  temp4 = ""
  temp5 = ""

  localInCode += 1
end

puts ""
puts "Output of code:"
puts output

#puts localInCode