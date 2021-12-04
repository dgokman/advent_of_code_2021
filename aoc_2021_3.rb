A = File.read("aoc_2021_3.txt")

arr = A.split("\n")

a = ""
c = ""
arr.map {|a| a.split("")}.transpose.each do |b|
  if b.count("1") > b.count("0")
    a << "1"
    c << "0"
  else
    a << "0"
    c << "1"
  end
end

p a.to_i(2)*c.to_i(2)  

# 2
oxygen = arr.clone
co2 = arr.clone

new_arr = arr.clone
arr.first.length.times do |i|
  break if arr.length == 1
  b = arr.map {|a| a.split("")}.transpose[i]
  if b.count("1") >= b.count("0")
    oxygen = oxygen.select {|a| a[i] == "1"}
  else
    oxygen = oxygen.select {|a| a[i] == "0"}
  end
  arr = oxygen.clone
end

new_arr.first.length.times do |i|
  break if new_arr.length == 1
  b = new_arr.map {|a| a.split("")}.transpose[i]
  if b.count("0") > b.count("1")
    co2 = co2.select {|a| a[i] == "1"}
  elsif b.count("0") <= b.count("1")
    co2 = co2.select {|a| a[i] == "0"}
  end
  new_arr = co2.clone
end

p arr.first.to_i(2)*new_arr.first.to_i(2)  

