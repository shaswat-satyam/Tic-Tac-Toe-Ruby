N = 3

def display(a)
  system('clear')
  a.each do |row|
    row.each do |cell|
      print "#{cell} "
    end
    puts
  end
end

def draw(a)
  a.each do |row|
    row.each do |cell|
      return false if cell == 0
    end
  end
  true
end

def set(a, m, n, player)
  a[n][m] = player
end

def playerMove(matrix, player)
  display(matrix)
  if draw(matrix)
    puts "No one Wins!\nThank you for playing."
    return true
  end
  puts "Player #{player} move (x,y):"
  while true
    m, n = gets.chomp.split.map(&:to_i)
    if matrix[n][m] != 0 || m > 2 || n > 2
      puts "Incorrect Move \nReenter the move(x,y): "
      next
    end
    set(matrix, n, m, player)
    break
  end
  display(matrix)
  if win(matrix, player)
    puts "\nMatch Over!\nThank you for Playing."
    return player
  end
  false
end

def win(a, player)
  # check rows
  a.each do |row|
    return true if row.all? { |cell| cell == player }
  end
  # check columns
  a.transpose.each do |column|
    return true if column.all? { |cell| cell == player }
  end
  # check diagonals
  return true if (0..2).all? { |i| a[i][i] == player }
  return true if (0..2).all? { |i| a[i][2-i] == player }
  false
end

def main
  matrix = Array.new(N) { Array.new(N, 0) }
  loop do
    break if playerMove(matrix, 1) || playerMove(matrix, 2)
  end
  puts "Want to have a reMatch ? (y/n)"
  choice = gets.chomp
  main if choice == 'y'
end

main
