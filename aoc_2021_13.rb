class NilClass
  def method_missing(*args); nil; end
end

class Array
  def fetch(index)
    if index < 0
      return nil
    end
    self[index]
  end
end

A = File.read("aoc_2021_13.txt")

a, b = A.split("\n\n")
arr = a.split("\n").map {|a| a.split(",")}
instructions = b.split("\n").map {|a| a.split(" ").last}

field = Array.new(2000){Array.new(2000){"."}}
 
arr.each do |j,i|
  i, j = i.to_i, j.to_i
  field[i][j] = "#"
end  

instructions.each_with_index do |n, idx|
  var, val = n.split("=")
  if var == "x"
    fold_x = val.to_i
    for j in fold_x+1..field.length
      for i in 0..field.length
        if field[i][j] == "#"
          field[i][j-2*(j-fold_x)] = "#"
          field[i][j] = "."
        end
      end  
    end 
  else
    fold_y = val.to_i
    for i in fold_y+1..field.length
      for j in 0..field.length
        if field[i][j] == "#"
          field[i-2*(i-fold_y)][j] = "#"
          field[i][j] = "."
        end
      end  
    end
  end
  # 1
  p field.flatten.count("#") if idx == 0
end    

# 2  
# output paper to get code 
field[0..10].each do |a|
  p a[0..50]
end  



  
