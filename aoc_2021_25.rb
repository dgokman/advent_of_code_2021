A = File.read("aoc_2021_25.txt")

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

field = A.split("\n").map {|x| x.split("")}
new_field = Marshal.load(Marshal.dump(field))
 
count = 0
steps = 0

loop do
  i = 0
  j = 0
  while i < field.length
    while j < field[i].length
      if field[i][j] == ">"
        if (j == field[i].length-1 && field[i][0] == ".")
          count += 1
          new_field[i][0] = ">"
          new_field[i][j] = "."
        end
        if field[i][j+1] == "."
          count += 1
          new_field[i][j+1] = ">"
          new_field[i][j] = "."
        end
      end
      j += 1
    end
    i += 1
    j = 0
  end 

  field = Marshal.load(Marshal.dump(new_field))
  new_field = Marshal.load(Marshal.dump(field))

  i = 0
  j = 0
  while i < field.length
    while j < field[i].length 
      if field[i][j] == "v"
        if (i == field.length-1 && field[0][j] == ".")
          count += 1
          new_field[0][j] = "v"
          new_field[i][j] = "."
        end
        if field[i+1][j] == "."

          count += 1
          new_field[i+1][j] = "v"
          new_field[i][j] = "."
        end
      end
      j += 1
    end
    i += 1
    j = 0
  end    

  field = Marshal.load(Marshal.dump(new_field))
  new_field = Marshal.load(Marshal.dump(field))

  steps += 1
  
  if count == 0
    p steps
    break
  end  
  count = 0
end