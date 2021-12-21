def move(start,n)
  n.times do
    start += 1
    if start == 11
      start = 1
    end
  end
  start    
end      

@dice = 1

def turn
  sum = 0
  3.times do
    sum += @dice
    @dice += 1
    if @dice > 100
      @dice = 1
    end
  end
  
  sum
end

def play1
  player1_score = 0
  player2_score = 0
  player1_start = 1
  player2_start = 6
  rolls = 0
  loop do
    player1_start = move(player1_start, turn)
    player1_score += player1_start
    rolls += 3
    break if player1_score >= 1000
    player2_start = move(player2_start, turn)
    player2_score += player2_start
    rolls += 3
    break if player2_score >= 1000
  end

  rolls * [player1_score, player2_score].min
end

def play2
  scores = Hash.new(0)
  player1_wins = 0
  player2_wins = 0
  scores[[1,6,0,0,1]] = 1
  new_scores = Hash.new(0)
  loop do
    (1..3).to_a.repeated_permutation(3).to_a.each do |a,b,c|
      scores.each do |(player1_start, player2_start, player1_score, player2_score, next_turn), v|
        if next_turn == 1
          player1_start = move(player1_start, a+b+c)
          player1_score += player1_start
          if player1_score >= 21
            player1_wins += v
          else
            new_scores[[player1_start, player2_start, player1_score, player2_score, 2]] += v
          end  
        else
          player2_start = move(player2_start, a+b+c)
          player2_score += player2_start

          if player2_score >= 21
            player2_wins += v
          else
            new_scores[[player1_start, player2_start, player1_score, player2_score, 1]] += v
          end 
        end  
      end  
    end
    break unless scores.any?
    scores = new_scores.clone
    new_scores = Hash.new(0)
  end  
  [player1_wins, player2_wins].max
end

# 1
p play1

# 2
p play2   