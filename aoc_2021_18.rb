A = File.read("aoc_2021_18.txt")

fish = A.split("\n").map {|a| eval(a)}

def add(a,b)
  [a,b]
end

def explode?(snail_fish)
  snail_fish.flatten(3).any? {|a| a.is_a?(Array)}
end

def split?(snail_fish)
  snail_fish.flatten.any? {|a| a >= 10}
end  

# TODO: Write a less hacky function
def explode(snail_fish)
  flattened = snail_fish.flatten(3)
  if exploder = flattened.find {|a| a.is_a?(Array)}
    idx = flattened.index(exploder)
    arr = snail_fish.flatten(4)
    zero_indices = []
    left_idx = nil
    right_idx = nil
    if idx == 0
      right_idx = 2
    else  
      left_idx = idx-1
      right_idx = idx+2 if flattened[idx+1]
    end      
    snail_fish_str = snail_fish.to_s
    if left_idx
      left_repl = exploder.first+arr[left_idx]
      i = 0
      count = 0
      loop do
        double = false
        if ("0".."9").to_a.include?(snail_fish_str[i])
          double = true if ("0".."9").to_a.include?(snail_fish_str[i+1])
          if count == left_idx
            snail_fish_str[i..(double ? i+1 : i)] = (arr[left_idx]+exploder[0]).to_s
            double = true if (arr[left_idx]+exploder[0]).to_s.length == 2
          end  
          if count == left_idx + 1
            zero_indices << i-1
          end
          if count == left_idx + 2  
            zero_indices << (("0".."9").to_a.include?(snail_fish_str[i+1]) ? i+2 : i+1)
            break
          end  
          count += 1
        end
        double ? i += 2 : i += 1
      end
    end
    if right_idx
      right_repl = exploder.last+arr[right_idx]
      i = 0
      count = 0
      loop do
        double = false
        if ("0".."9").to_a.include?(snail_fish_str[i])
          double = true if ("0".."9").to_a.include?(snail_fish_str[i+1])
          if count == right_idx
            snail_fish_str[i..(double ? i+1 : i)] = (arr[right_idx]+exploder[1]).to_s
            break
          end  
          count += 1
        end
        double ? i += 2 : i += 1
      end  
    end     
  end
  if left_idx
    snail_fish_str[zero_indices[0]..zero_indices[1]] = "0"
  else
    snail_fish_str.sub!(exploder.to_s, "0")
  end    
  eval(snail_fish_str)
end    

def split(snail_fish)
  flattened = snail_fish.flatten
  snail_fish_str = snail_fish.to_s
  splitter, idx = flattened.each_with_index.find {|a,i| flattened[i] >= 10}
  if splitter
    repl = [splitter/2, splitter-(splitter/2)].to_s
    i = 0
    count = 0
    loop do
      double = false
      if ("0".."9").to_a.include?(snail_fish_str[i])
        double = true if ("0".."9").to_a.include?(snail_fish_str[i+1])
        if count == idx
          snail_fish_str[i..i+1] = repl
          break
        end  
        count += 1
      end
      double ? i += 2 : i += 1
    end
  end

  eval(snail_fish_str)
end    

def reduce(snail_fish)
  until !explode?(snail_fish) && !split?(snail_fish)
    until !explode?(snail_fish)
      snail_fish = explode(snail_fish)
    end  
    
    if split?(snail_fish)
      snail_fish = split(snail_fish)
    end  
  end

  snail_fish  
end


def recurse(obj)
  if obj.class == Array && obj.any? {|a| a.is_a? Array }
    obj.each { |a| recurse(a) }
  elsif obj.class == Array
    @arr.gsub!(obj.to_s, (3*obj.first+2*obj.last).to_s)
    arr = eval(@arr)
    recurse(arr)
  end  
end


i = 0
while i < fish.length-1
  if i == 0
    snail_fish = reduce(add(fish[0],fish[1]))
  else
    snail_fish = reduce(add(snail_fish,fish[i+1]))  
  end
  i += 1
end

@arr = snail_fish.to_s
recurse(snail_fish)

# 1
p @arr.to_i

# 2
max = 0
fish.combination(2).each do |fish1, fish2|

  snail_fish = reduce(add(fish1, fish2))
  @arr = snail_fish.to_s
  recurse(snail_fish)
  if @arr.to_i > max
    max = @arr.to_i
  end  

  snail_fish = reduce(add(fish2, fish1))
  @arr = snail_fish.to_s
  recurse(snail_fish)
  if @arr.to_i > max
    max = @arr.to_i
  end
end

p max
