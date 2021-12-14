A = File.read("aoc_2021_14.txt")

val = "VOKKVSKKPSBVOOKVCFOV"

arr = A.split("\n")

hash = {}
arr.map {|a| a.split(" -> ")}.each do |a,b|
  hash[a] = b
end

ins_hash = Hash.new(0)
counts = Hash.new(0)

val.split("").each do |a|
  counts[a] += 1
end  
val.split("").each_cons(2).each do |a|
  ins_hash[a.join] += 1
end  

40.times do |n|
  new_hash = ins_hash.clone
  ins_hash.each do |k,v|
    insert = hash[k]
    counts[insert] += v
    new_hash[k] -= v
    new_hash[k[0]+insert] += v
    new_hash[insert+k[1]] += v
  end
  ins_hash = new_hash.clone
  # 1
  p counts.values.sort.last - counts.values.sort.first if n == 9 
end

# 2
p counts.values.sort.last - counts.values.sort.first      

  