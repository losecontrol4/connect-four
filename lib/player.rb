# Player class, contains infomation like player name, their token, and their current score

class Player
  attr_reader :name, :score, :token

  @@token_list = ['x']
  def initialize(name)
    @name = name
    @score = 0
    @token = get_valid_token
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

  private

  def get_valid_token
    @name
  end
end
