A = File.read("aoc_2021_5.txt")

2.times do |n|
  arr = A.split("\n").map {|a| a.split(" -> ")}
  field = Array.new(1000){Array.new(1000){0}}

  arr.each do |a, b|
    x1, x2 = a.split(",")[1].to_i, b.split(",")[1].to_i
    y1, y2 = a.split(",")[0].to_i, b.split(",")[0].to_i
    if y1 == y2
      for x in [x1, x2].min..[x1, x2].max 
        field[x][y1] += 1
      end
    elsif x1 == x2
      for y in [y1, y2].min..[y1, y2].max 
        field[x1][y] += 1
      end 
    elsif n == 1
      xx, yy = x1, y1
      if x1 < x2 && y1 > y2
        while xx <= x2
          field[xx][yy] += 1
          xx += 1
          yy -= 1
        end
      elsif x1 < x2 && y1 < y2
        while xx <= x2
          field[xx][yy] += 1
          xx += 1
          yy += 1
        end
      elsif x1 > x2 && y1 > y2
        while xx >= x2
          field[xx][yy] += 1
          xx -= 1
          yy -= 1
        end
      elsif x1 > x2 && y1 < y2
        while xx >= x2
          field[xx][yy] += 1
          xx -= 1
          yy += 1
        end
      end  
    end    
  end
  p field.flatten.count {|a| a > 1}
end
