# Player class, contains infomation like player name, their token, and their current score

class Player
  attr_reader :name, :score, :token 
	"⚪ ⚫ ⚾ ⛄ ☺ ☹ ⚰ ☮ ☆ ★ ⛑ ♈ ⚽"
  def initialize(name)
    @name = name
    @score = 0
    set_valid_token
  end

  def increment_score
    @score += 1
  end

  def get_move(board)
    # returns a valid move
    puts "#{@name}, what's your move? (You are currently #{@token})"
    input_valid = false
    until input_valid
      input = gets.chomp
      if input.length != 1 || !(input.to_i > 0 && input.to_i < 8)
        puts "#{@name}, please enter a valid number, 1 through 7"
        next # jumps to the top of the while loop
      end
      if (board[0][input.to_i - 1] != "-")
        puts "#{@name}, please choose a column that isn't full"
        next # jumps to the top of the while loop
      end
      input = input.to_i
      # TODO: check if board column is full

      # if board.gameboard[input - 1] != ' '
      #   puts "#{@name}, please choose a spot that has not been chosen"
      #   next # jumps to the top of the while loop
      # end

      input_valid = true
    end
    input
  end

  def set_valid_token
    valid_options = %w(☺ ☹ ☮ ☆ ★ ⛑ x ♥ o ∆ π)
    selectors = %w(0 1 2 3 4 5 6 7 8 9 q)


    puts "#{@name}, choose your token!"
    puts valid_options.join(" ")
    puts selectors.join(" ")
    input_valid = false
    until input_valid
      input = gets.chomp
      if input.length != 1
        puts "#{@name}, please enter a value with only one character"
        next # jumps to the top of the while loop
      end
      if !selectors.include?(input)
        puts "#{@name}, please choose an option presented to you"
        next # jumps to the top of the while loop
      end

      input_valid = true
      input == 'q' ? input_val = 10 : input_val = input.to_i
    end
    @token = valid_options[input_val]
    puts "you chose #{@token}"
  end
end
