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
low_points = []

i = 0
j = 0
while i < field.length
  while j < field[i].length
    adjacent_acres = [field.fetch(i-1).fetch(j), field.fetch(i).fetch(j-1),field.fetch(i+1).fetch(j), field.fetch(i).fetch(j+1)]

    if adjacent_acres.reject {|a| a.nil?}.map(&:to_i).all? {|b| field[i][j].to_i < b}
      low_points << [i,j]
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
@visited = Hash.new(0)

def count_basin(field, i, j, basin)
  @hash[basin] += 1
  
  dirs = [[-1, 0], [0, -1], [1, 0], [0, 1]]
  dirs.map {|ii,jj| [i+ii, j+jj]}.select {|i,j| field.fetch(i).fetch(j) == "." && @visited[[i,j]] == 0}.each do |ii,jj|
    @visited[[ii,jj]] += 1

    count_basin(field, ii, jj, basin) unless @visited[[ii,jj]] > 1
  end
end

low_points.each_with_index do |(i,j), idx|
  count_basin(field, i, j, idx)
end  

p @hash.values.map {|a| a-1}.sort[-3..-1].inject(:*)


