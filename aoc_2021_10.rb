A = File.read("aoc_2021_10.txt")

arr = A.split("\n")

def illegal_score(str, problem=1)
  opening = {"[" => "]", "(" => ")", "<" => ">", "{" => "}"}
  closing = {")" => 3, "]" => 57, "}" => 1197, ">" => 25137}
  
  vals = []
  str.split("").each_with_index do |s, i|
    if opening.keys.include?(s)
      vals.unshift(opening[s])
    elsif closing.keys.include?(s)
      unless s == vals[0]
        return problem == 1 ? closing[s] : []
      end
      vals.shift
    end
  end
  problem == 1 ? 0 : vals
end

score = 0
arr.each do |a|
  score += illegal_score(a)
end

# 1
p score 

completion = {")" => 1, "]" => 2, "}" => 3, ">" => 4}
scores = []
arr.each do |a|
  score = 0
  illegal_score(a, 2).each do |b|
    score = (score*5)+completion[b]
  end
  scores << score unless score == 0
end    

p scores.sort[scores.length/2]

