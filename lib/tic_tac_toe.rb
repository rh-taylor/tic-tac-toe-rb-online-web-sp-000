#WIN_COMBINATIONS constant - defines the indexes of winning combinations
WIN_COMBINATIONS = [
  [0,1,2], #Top row, index 0  
  [3,4,5], #Middle row, 1
  [6,7,8], #Bottom row, 2
  [0,3,6], #Left vert row, 3
  [1,4,7], #Mid vert row, 4
  [2,5,8], #Right vert row, 5
  [0,4,8], #Left diagonal, 6
  [2,4,6], #Right diagonal, 7
]


#display_board - prints the current board representation based on the (board) argument passed to the method
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


#input_to_index - converts user input to the board index
def input_to_index(input)
  index = input.to_i - 1
end


#move - places the player's token on the board using player input
def move(board, index, current_player)
  board[index] = current_player
end


#position_taken? - evaluates the position selected by the user and checks to see if it is occupied
def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end


#valid_move? - determines whether or not a player's move is valid
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end


#turn_count - returns the number of turns that have been played on the current board
def turn_count(board)
  counter = 0
  board.each do |spaces|
    if spaces == "X" || spaces == "O"
      counter += 1
    end
  end
  return counter
end


#current_player - evaluates the board to determine if it is X's turn or O's turn
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

  
#turn - asks for user input, receives user input, converts user input, evaluates move's validity, makes move and displays board if valid, asks for new input if invalid
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end    
end


#won? - determines if there is a win
def won?(board)
  WIN_COMBINATIONS.each do |win_combo|  #|win_combo| is a placeholder
    win_index_1 = win_combo[0]  #win_combo[0], [1], and [2] each stand for one of the three indexes that make a winning index?
    win_index_2 = win_combo[1]  #win_index grabs each index (individual spot on board) that composes a win
    win_index_3 = win_combo[2]
    
    position_1 = board[win_index_1]  #load the value of the board at win_index_1
    position_2 = board[win_index_2]  #load the value of the board at win_index_2
    position_3 = board[win_index_3]  #Load the value of the board at win_index_3
    
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combo  #if all three positions contain an "X" or "O,"
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combo  #return the win_combination indexes that won
    end
  end
  return false #if the conditions are not met, return false(?)
end


#full? - determines if the board is full
def full?(board)
  board.all? {|index| index == "X" || index == "O"}  #Are all of the board's indexes filled with either an "X" or an "O"? If yes, true; if not, false
end


#draw? - determines if the game has ended in a draw
def draw?(board)
  if !won?(board) && full?(board)  #Is the game not won but there is a full boad? If yes, true; if not, false.
    return true
  else
    return false
  end
end


#over? - determines if the game is over (i.e. has been won, is a draw, or full board with no winner)
def over?(board)
  if draw?(board) || won?(board) || full?(board)   #Is there a draw (#draw?(board) returns true) or is there is a win and a full board or is there is a win without a full board? If yes, true; if not, false.
    return true
  else
    return false
  end
end


#winner - determines the winner, X or O
def winner(board)
  index = []
  index = won?(board)  #Has a win been determined with #won?(board)? A win would return the three indexes that make up a winning combination. If #won?(board) returns false (no win), winner(board) will return nil.
  if index == false
    return nil
  else
    if board[index[0]] == "X"  #But if board[index[0]]  -- unsure what board[index[0]] is -- has a winning combination with "X" tokens, return "X," otherwise return "Y."
      return "X"
    else
      return "O"
    end
  end
end


#play
def play(board)
  while over?(board) == false
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end