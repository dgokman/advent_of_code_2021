require 'set'

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

CONFIG = "#############
#...........#
###C#A#B#D###
  #D#C#A#B#
  #########"


config = CONFIG.split("\n").map {|a| a.split("")}

GOAL_CONFIG = "#############
#...........#
###A#B#C#D###
  #A#B#C#D#
  #########"

goal_config = GOAL_CONFIG.split("\n").map {|a| a.split("")}  

def blocks_by_type(config, type)
  arr = []
  for i in 0..config.length-1
    for j in 0..config[i].length-1
      if config[i][j] == type
        arr << [i,j]
      end
    end
  end
  arr      
end

def possible_moves(config)
  possible_moves = {}
  empty_spaces = blocks_by_type(config, ".")
  
  ["A","B","C","D"].each do |type|
    blocks = blocks_by_type(config, type)
    possible_moves_by_block_type(type, blocks, empty_spaces).each do |a|
      possible_moves[type] ||= []
      possible_moves[type] << a
    end
  end  

  possible_moves 
end

def possible_moves_by_block_type(type, blocks, empty_spaces)
  moves = []
  destinations = {"A"=>[[3,3],[2,3]],
    "B"=>[[3,5],[2,5]],
    "C"=>[[3,7],[2,7]],
    "D"=>[[3,9],[2,9]]
  }

  dest = destinations[type]
  return moves if blocks.sort.reverse == dest
  first = false
  if blocks.include?(dest[0])
    first = true
    blocks = blocks.reject { |a| dest[0] == a }
  end
  hallway_left = blocks.select { |a,b| a == 1 && b < dest.last.last }
  hallway_right = blocks.select { |a,b| a == 1 && b > dest.last.last }
  room = blocks.select { |a| a.first == 2 || a.first == 3 }
  hallway_left.each do |block|
    empty = empty_spaces.select {|c,d| c == 1 && d.between?(block.last,dest.last.last) }.transpose.last.sort.uniq == (block.last+1..dest.last.last).to_a
    if empty_spaces.include?(dest.first) && empty
      moves << [block,dest.first]
    elsif empty_spaces.include?(dest.last) && first && empty
      moves << [block,dest.last]
    end
  end
  hallway_right.each do |block|
    empty = empty_spaces.select {|c,d| c == 1 && d.between?(dest.last.last,block.last) }.transpose.last.sort.uniq == (dest.last.last..block.last-1).to_a
    if empty_spaces.include?(dest.first) && empty
      moves << [block,dest.first]
    elsif empty_spaces.include?(dest.last) && first && empty
      moves << [block,dest.last]
    end
  end  
  room.each do |block|
    next unless empty_spaces.include?([block.first-1,block.last])
    [[1,1],[1,2],[1,4],[1,6],
    [1,8],[1,10],[1,11]].each do |a,b|
      if (block.last > b && empty_spaces.select {|c,d| c == 1 && d.between?(b,block.last) }.transpose.last.sort.uniq == (b..block.last).to_a) ||
        (block.last < b && empty_spaces.select {|c,d| c == 1 && d.between?(block.last,b) }.transpose.last.sort.uniq == (block.last..b).to_a)
        moves << [block, [a,b]]
      end
    end
  end      

  moves
end

def move(config, start, finish, type)
  a,b = start
  config[a][b] = "."

  c,d = finish
  config[c][d] = type

  config
end  

def calculate_move(start, finish, type)
  multiplier = {"A" => 1, "B" => 10, "C" => 100, "D" => 1000}
  ((start.first-finish.first).abs+(start.last-finish.last).abs)*multiplier[type]
end

paths_by_hash = Hash.new(Float::INFINITY)
configs = [config]
new_configs = nil
n = 0
loop do
  new_paths_by_hash = Hash.new(Float::INFINITY)
  new_configs = Set.new
  configs.each do |config|
    moves = possible_moves(config)
    moves.each do |type, move|
      move.each do |m|
        start, finish = m
        sub_config = Marshal.load(Marshal.dump(config))
        
        new_config = move(sub_config, start, finish, type)
        points = calculate_move(start, finish, type)
        if n == 0
          new_paths_by_hash[new_config] = points
        elsif points + paths_by_hash[config] < new_paths_by_hash[new_config]
          new_paths_by_hash[new_config] = paths_by_hash[config] + points
        end   
        new_configs << new_config
      end
    end 
  end
  paths_by_hash = new_paths_by_hash.clone
  
  configs = new_configs.clone
  if configs.include?(goal_config)
    p paths_by_hash[goal_config]
    break
  end 

  n += 1 
end