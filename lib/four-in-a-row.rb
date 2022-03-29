class FourInARow
  #the FourInARow class provides all the tools needed play a single 
  #two player game of four in a row (or connect four). After providing two player objects,
  #calling the play function handles everything.

  def initialize(player1, player2)
    @p1 = player1
    @p2 = player2
    @board = Array.new(6) { Array.new(7, '-') }
    @turns = 0
    @last_move_cords = nil
    @game_over = false
    @winner = nil
  end

  def board
    @board.map(&:clone) # prevents it from being written to accidently
  end

  def play 
    # where everything happens, returns a the winner (if there is one) and increment their score
    play_four_in_a_row #plays a round of four in a row
    @winner.increment_score unless @winner.nil? 
    ending_message(@winner)
    @winner
  end

  private 
  
  def play_four_in_a_row
    # this function controls the flow for a single game
    introduction
    until @game_over
      #player1 turn
      puts self
      update_board(@p1)
      @turns += 1
      check_if_game_won(@p1)
    #---------------------
      next if @game_over
     # player2 turn
      puts self
      update_board(@p2)
      @turns += 1
      check_if_game_won(@p2)
    end
  end

  def introduction
    puts "Welcome to Four in a Row! The object of the game is to make your pieces to connect four times in a row, horizontaly, vertically, or diagonoly."
  end

  def ending_message(player)
    puts self
    tie = player.nil?
    if tie
      puts "After an intense match, #{@p1.name} and #{@p2.name} couldn't best each other. The match ended in a draw.\nAs the dust clears, they must choose whether to fight again or live in peace...but, peace was never an option."
    else
      puts "#{player.name} won!" #update message
    end

  end

  def check_if_game_won(player)
    # checks if the last move was a winning move by checking a three by three grid around the move, and follows each path recurisvely if it has a match.

    return unless @turns > 6 # can't win in under 6 turns
    if @turns >= 42 # this means the whole 6 by 7 board is full
      @game_over = true
      return
    end

    curr_cords = @last_move_cords

    Array(-1..1).each do |i| # our three by three grid checking
      row = i + curr_cords[0]
      next if row < 0 || row > 6 - 1
      Array(-1..1).each do |j|
        next if i == 0 && j == 0 # exclude checking self
        col = j + curr_cords[1]
        next if col < 0 || col > 7 - 1

        if @board[row][col] == player.token
          count = check_if_game_won_helper([row, col], 2, player, i, j) + check_if_game_won_helper([(row - i), (col - j)], 0, player, -1 * i, -1 * j)
          #checks the current path plus the inverse path to find if there is four in a row
          
          if count >= 4
            @game_over = true
            @winner = player
            return
          end
        end
      end
    end
  end

  def check_if_game_won_helper(curr_cords, count, player, row_direction, col_direction)
    #follows a path recursively and returns how many of the same token appear in a row

    row = row_direction + curr_cords[0]
    col = col_direction + curr_cords[1]

    return count if (row < 0 || row > 6 - 1) || (col < 0 || col > 7 - 1) #out of bounds

    if @board[row][col] == player.token
      check_if_game_won_helper([row, col], count + 1, player, row_direction, col_direction) 
    else
      return count
    end
  end
  
   



  def update_board(player)
    move = player.get_move(@board) # only valid numbers can return from this function
    row = 5
    row -= 1 while @board[row][move - 1] != '-'
    @last_move_cords = [row, move - 1]
    @board[row][move - 1] = player.token
  end

  def to_s
    #                    
    #    1 2 3 4 5 6 7
    # ___________________
    #  | - - - - - - - |
    #  | - - - - - - - |
    #  | - - - - - - - |
    #  | - - - - - - - |
    #  | - - - - - - - |
    #  | - - - - - - - |
    # –––             –––
    result = "\n    1 2 3 4 5 6 7\n ___________________"
    @board.each do |row|
        line = '  | '
        row.each {|column| line += "#{column} " }
        line += "|" 
        result += "\n#{line}"
    end
    result += "\n –––             –––"
    result
  end
end

