A = "7777838353
2217272478
3355318645
2242618113
7182468666
5441641111
4773862364
5717125521
7542127721
4576678341"

class NilClass
  def method_missing(*args); nil; end
end

class Array
  def fetch(index)
    if index < 0
      return nil
    end
    self[index]
  end
end

def flash(field, i, j)
  [-1, 0, 1].each do |ii|
    [-1, 0, 1].each do |jj|
      next if ii == 0 && jj == 0
      if field.fetch(i+ii).fetch(j+jj).to_i > 0
        field[i+ii][j+jj] == 9 ? field[i+ii][j+jj] = 0 : field[i+ii][j+jj] += 1
        if field[i+ii][j+jj] == 0
          @flashes += 1
          flash(field, i+ii, j+jj)
        end
      end
    end
  end 
  field
end        

@flashes = 0
field = A.split("\n").map {|x| x.split("").map(&:to_i)}
steps = 1
loop do
  flashed = []
  i = 0
  j = 0
  while i < field.length
    while j < field[i].length
      field[i][j] == 9 ? field[i][j] = 0 : field[i][j] += 1

      if field[i][j] == 0
        flashed << [i,j]
        @flashes += 1
      end
      j += 1
    end
    i += 1
    j = 0
  end  

  flashed.each do |i,j|
    field = flash(field, i, j)
  end  
  
  if field.flatten.all? {|a| a == 0} 
    p steps
    break
  end 
  p @flashes if steps == 100
  steps += 1   
end

