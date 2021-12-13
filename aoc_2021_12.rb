require 'set'

A = "start-YA
ps-yq
zt-mu
JS-yi
yq-VJ
QT-ps
start-yq
YA-yi
start-nf
nf-YA
nf-JS
JS-ez
yq-JS
ps-JS
ps-yi
yq-nf
QT-yi
end-QT
nf-yi
zt-QT
end-ez
yq-YA
end-JS"

graph = {}
A.split("\n").map {|a| a.split("-")}.each do |b,c|
  graph[b] ||= []
  graph[b] << c
  graph[c] ||= []
  graph[c] << b
end    

def valid_path_one?(path, graph)
  single = graph.keys.select {|a| a == a.downcase}
  single.each do |a|
    if path.count(a) > 1
      return false
    end
  end
  true    
end

def valid_path_two?(path, graph)
  single = graph.keys.select {|a| a == "start" || a == "end"}
  double = graph.keys.select {|a| a.length <= 2 && a == a.downcase}
  single.each do |a|
    if path.count(a) > 1
      return false
    end
  end
  visited = false
  double.each do |a|
    if path.count(a) > 2
      return false
    elsif path.count(a) == 2
      return false if visited
      visited = true
    end  
  end
  true    
end

def paths(graph, problem=1)
  finished = Set.new
  count = 0
  arrs = [["start"]]
  loop do
    new_arrs = arrs.to_set
    arrs.each do |arr|
      new_arr = arr.clone
      graph[arr.last].each do |y|
        new_new_arr = new_arr.clone
        new_new_arr << y
        if y == "end"
          finished << new_new_arr
        else  
          new_arrs << new_new_arr
        end  
      end
    end
    return count if count > 0 && finished.length == count
    count = finished.length
    arrs = new_arrs.select {|a| problem == 1 ? valid_path_one?(a,graph) : valid_path_two?(a,graph)}
  end
end

p paths(graph, 1)
p paths(graph, 2)
