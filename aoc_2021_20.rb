A = File.read("aoc_2021_20.txt")

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

algo, field = A.split("\n\n")

field = field.split("\n").map {|a| a.split("")}
input = Array.new(700){Array.new(700){"."}}

for i in 0..input.length
  for j in 0..input.length
    if field[i][j] == "#"
      input[i+200][j+200] = "#"
    end
  end
end      

field = Marshal.load(Marshal.dump(input))
new_field = Marshal.load(Marshal.dump(field))

times = 50
times.times do |n|
  i = 0
  j = 0
  while i < field.length
    while j < field.length
      check = false

      adjacent_acres = [field.fetch(i-1).fetch(j-1), field.fetch(i-1).fetch(j), field.fetch(i-1).fetch(j+1), 
          field.fetch(i).fetch(j-1), field.fetch(i).fetch(j), field.fetch(i).fetch(j+1), 
          field.fetch(i+1).fetch(j-1), field.fetch(i+1).fetch(j), field.fetch(i+1).fetch(j+1)]

      code = adjacent_acres.map {|a| a == "#" ? "1" : "0"}.join.to_i(2)

      if algo[code] == "#"
        new_field[i][j] = "#"
      else
        new_field[i][j] = "."
      end    

      j += 1
    end
    i += 1
    j = 0
  end 

  if n < times-1
    field = Marshal.load(Marshal.dump(new_field))
    new_field = Marshal.load(Marshal.dump(field))
  end 
  
  # 1          # 2
  if n == 1 || n == times-1
    sum = 0

    new_field[150..-150].each do |a|
      sum += a[150..-150].count("#")
    end

    p sum
  end  
end

