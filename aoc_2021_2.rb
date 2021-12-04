A = File.read("aoc_2021_2.txt")

arr = A.split("\n")

pos = 0
depth = 0

arr.map {|a| a.split(" ")}.each do |dir, num|
  if dir == "forward"
    pos += num.to_i
  elsif dir == "up"
    depth -= num.to_i
  else
    depth += num.to_i
  end 
end
     
p pos*depth

aim = 0
pos = 0
depth = 0
arr.map {|a| a.split(" ")}.each do |dir, num|
  if dir == "forward"
    pos += num.to_i
    depth += (aim*num.to_i)
  elsif dir == "up"
    aim -= num.to_i
  else
    aim += num.to_i
  end 
end

p pos*depth

