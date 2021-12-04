A = File.read("aoc_2021_4.txt")

vals = A.split("\n\n")
numbers = vals.first.split(",")
boards = vals[1..-1]
boards = boards.map {|a| a.split(" ")}.map {|a| a.each_slice(5).to_a}

def bingo?(board)
  return true if board.any? {|a| a.uniq.length == 1 && a.uniq.first == "x"}
  return true if board.transpose.any? {|a| a.uniq.length == 1 && a.uniq.first == "x"}
  false
end  

winning_boards = {}
found = false
numbers.length.times.each do |n|
  new_boards = Marshal.load(Marshal.dump(boards))
  boards.each_with_index do |board, idx|
    
    for i in 0..board.length-1
      for j in 0..board.length-1
        if board[i][j] == numbers[n]
          new_boards[idx][i][j] = "x"
        end
      end
    end
  end
  new_boards.each_with_index do |board, idx|
    if bingo?(board)
      winning_boards[idx] = [numbers[n], board] unless winning_boards[idx]
      # 1
      p numbers[n].to_i * board.flatten.map {|a| a.to_i}.inject(:+) unless found
      found = true
    end
  end   
  boards = Marshal.load(Marshal.dump(new_boards))
end

# 2
p winning_boards.to_a.last.last.first.to_i * winning_boards.to_a.last.last.last.flatten.map {|a| a.to_i}.inject(:+)

