Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file } #way to load everything in lib thanks to this stack overflow post https://stackoverflow.com/questions/735073/best-way-to-require-all-files-from-a-directory-in-ruby 





SCORE_TO_WIN = 5

# get player names and give an introduction

puts '-----------------------------------------------------'
puts "Welcome, you two will play four in a row to the death! First to #{SCORE_TO_WIN} wins!"
puts 'Please enter one of your names:'
player1 = gets.chomp
puts "Welcome #{player1}!"
puts 'Please enter the other persons name:'
player2 = gets.chomp
puts "Welcome #{player2}!"

if player1 == player2 # If the players enter the same exact string, then create a way to differ between the two
  puts "well that's confusing..."
  player2 += '2'
  puts "the second player is now #{player2}"
end

# create player object
player1 = Player.new(player1)
player2 = Player.new(player2)

while player1.token == player2.token
    puts "#{player2.name} please choose a different token than #{player1.name}"
    player2.set_valid_token
end

player1, player2 = player2, player1 if rand(0..1).zero? # randomly swaps who goes first



while player1.score < SCORE_TO_WIN && player2.score < SCORE_TO_WIN
    # create game

    game = FourInARow.new(player1, player2) #player1 and 2 swap after each game
    last_winner = game.play


    puts 'The score is:'
    puts "#{player1.name}: #{player1.score}"
    puts "#{player2.name}: #{player2.score}"
    puts "First to #{SCORE_TO_WIN} wins" unless last_winner.score == SCORE_TO_WIN
    
    player1, player2 = player2, player1 #swaps who is player one and who is player two

  end

puts "After a tough fight, #{last_winner.name} won, #{player1.score} to #{player2.score}. They are the best, around. Nobody's going to put them down."