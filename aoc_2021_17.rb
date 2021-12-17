def hit_target?(init_x, init_y, target_x1, target_x2, target_y1, target_y2)
  max_y = 0
  x, y = [0,0]
  loop do
    if x.between?(target_x1, target_x2) && y.between?(target_y1, target_y2)
      return max_y
    elsif y < target_y1
      return false
    end    
    x += init_x
    y += init_y
    if y > max_y
      max_y = y
    end  
    x_change = if init_x > 0
      -1
    elsif init_x < 0
      1
    else
      0
    end

    y_change = -1
    init_x += x_change
    init_y += y_change
  end  
end  

max = 0
count = 0
for x in 0..300
  for y in (-300..300).to_a.reverse
    if sub = hit_target?(x,y,70,125,-159,-121)
      count += 1
      if sub > max
        max = sub
      end
    end
  end
end        

# 1
p max

# 2
p count