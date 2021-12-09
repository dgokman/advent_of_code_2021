A = File.read("aoc_2021_9.txt")

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

# 1
field = A.split("\n").map {|x| x.split("")}
count = 0

i = 0
j = 0
while i < field.length
  while j < field[i].length
    adjacent_acres = [field.fetch(i-1).fetch(j), field.fetch(i).fetch(j-1),field.fetch(i+1).fetch(j), field.fetch(i).fetch(j+1)]

    if adjacent_acres.reject {|a| a.nil?}.map(&:to_i).all? {|b| field[i][j].to_i < b}
      count += field[i][j].to_i+1
    end  
    j += 1
  end
  i += 1
  j = 0
end  

p count

# 2

i = 0
j = 0
basin = 0
while i < field.length
  while j < field[i].length
    if field[i][j] == "9"
      field[i][j] = "*"
    else
      field[i][j] = "."
    end  
    j += 1
  end
  i += 1
  j = 0
end 

@hash = Hash.new(0)

def count_basin(field, i, j, basin)
  return [field, basin] if field[i][j] != "."
  count = 1
  field[i][j] = count
  5000.times do
    adjacents = [field.fetch(i-1).fetch(j), field.fetch(i).fetch(j-1),field.fetch(i+1).fetch(j), field.fetch(i).fetch(j+1)]
    dirs = []
    if adjacents[0] && adjacents[0] != "*"
      dirs << [-1, 0]
    end  
    if adjacents[1] && adjacents[1] != "*"
      dirs << [0, -1]
    end  
    if adjacents[2] && adjacents[2] != "*"  
      dirs << [1, 0]
    end  
    if adjacents[3] && adjacents[3] != "*"  
      dirs << [0, 1]
    end  
    
    dir = dirs.sample
    i += dir[0]
    j += dir[1]
    unless field[i][j].to_i > 0
      count += 1
      field[i][j] = count 
    end  
  end
  basin += 1
  @hash[basin] = count
  [field, basin]
end

i = 0
j = 0
new_field = Marshal.load(Marshal.dump(field))
while i < field.length
  while j < field[i].length
    new_field, basin = count_basin(new_field, i, j, basin) 
    j += 1
  end
  i += 1
  j = 0
end 

p @hash.values.sort[-3..-1].inject(:*)


