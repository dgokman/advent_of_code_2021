A = File.read("aoc_2021_15.txt")

arrs = []

class Fixnum
  def add(x)
    self + x > 9 ? (self + x) % 9 : self + x   
  end
end

same_arrs = []

len = nil
A.split("\n").each do |arr|
  same_arrs << arr.split("").map(&:to_i)
  len = arr.length
  combined = []
  5.times do |n|
    new_arr = arr.clone
    combined += arr.split("").map {|a| a.to_i.add n}
  end 
  arrs << combined
end

new_arrs = arrs.clone
4.times do |o|
  arrs[len*o..len*o+(len-1)].each do |arr|
    new_arr = arr[0..len-1].map {|a| a.add 1}
    combined = []
    5.times do |n|
      combined += new_arr.map {|a| a.add n}
    end
    new_arrs << combined
  end
  arrs = new_arrs.clone
end  

#1, #2
[same_arrs, new_arrs].each do |matrix|
  min = Array.new(matrix.size) { Array.new(matrix.size, Float::INFINITY) }
  min[0][0] = matrix[0][0]
  queue = [[0,0]]
  until queue.empty?
    x,y = queue.pop
    for nx,ny in [
      ([x+1,y] if x+1 < matrix.size),
      ([x,y+1] if y+1 < matrix.size),
      ([x-1,y] if x > 0),
      ([x,y-1] if y > 0)
    ].compact
      if (new_sum = min[y][x] + matrix[ny][nx]) < min[ny][nx]
        min[ny][nx] = new_sum
        queue.unshift [nx, ny]
      end
    end
  end
  p min[-1][-1]-same_arrs[0][0]
end
