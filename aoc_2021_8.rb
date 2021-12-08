A = File.read("aoc_2021_8.txt")

arr = A.split("\n")
arr = arr.map {|a| a.split(" | ")}

nums_mapping = {
  "abcefg".split("") => "0",
  "cf".split("") => "1",
  "acdeg".split("") => "2",
  "acdfg".split("") => "3",
  "bcdf".split("") => "4", 
  "abdfg".split("") => "5", 
  "abdefg".split("") => "6", 
  "acf".split("") => "7", 
  "abcdefg".split("") => "8",
  "abcdfg".split("") => "9" 
}

sub_total = 0
sum = 0
arr.each do |a,z|
  b = a.split(" ")
  mapping = {}
  seg_mapping = {}
  counts = Hash.new(0)
  b.each do |c|
    case c.length
    when 2
      mapping[1] = c.split("")
    when 3
      mapping[7] = c.split("")
    when 4
      mapping[4] = c.split("")
    when 7
      mapping[8] = c.split("")  
    end
    c.split("").each do |d|
      counts[d] += 1
    end  
  end
  seg_mapping["a"] = (mapping[7] - mapping[1]).first
  seg_mapping["b"] = counts.select {|k,v| v == 6}.first.first
  seg_mapping["d"] = (mapping[4] - mapping[1] - [seg_mapping["b"]]).first
  seg_mapping["e"] = counts.select {|k,v| v == 4}.first.first
  seg_mapping["f"] = counts.select {|k,v| v == 9}.first.first
  seg_mapping["c"] = (mapping[1] - [seg_mapping["f"]]).first
  seg_mapping["g"] = counts.select {|k,v| v == 7 && !seg_mapping.values.include?(k)}.first.first
  seg_mapping = seg_mapping.to_a.map {|a| a.reverse}.to_h
  b = z.split(" ")
  num = ""
  b.each do |c|
    num << nums_mapping[c.split("").map {|d| seg_mapping[d]}.sort]
  end
  sub_total += num.split("").count {|a| ["1","4","7","8"].include?(a)}
  sum += num.to_i
end   

# 1
p sub_total

# 2
p sum   

