A = File.read("aoc_2021_1.txt")

arr = A.split("\n").map(&:to_i)

# 1

p arr.each_cons(2).count {|a,b| b > a}

# 2

p arr.each_cons(4).count {|a,b,c,d| b+c+d > a+b+c }