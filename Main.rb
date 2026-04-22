puts "Welcome to AMOC"
puts "Please enter your Aquamarine code here:"
puts ""
print ""
code = gets.chomp

#if code.include?("p ")
#  puts "67"
#end

localInCode = 0

codeAsList = code.chars

output = ""
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
            output += printables
        end
      end
    end
  end

  localInCode += 1
end

puts ""
puts "Output of code:"
puts output

#puts localInCode