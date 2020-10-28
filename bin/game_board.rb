require 'colorize'
class Board
  attr_reader :board, :winner
  attr_writer :board
  def initialize
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @winner = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
      [1, 5, 9],
      [9, 5, 1],
      [1, 4, 7],
      [2, 5, 8],
      [3, 6, 9]
    ]
  end

  def display_board
    puts " #{@board[0]}|#{@board[1]}|#{@board[2]}"
    puts ' ----- '.yellow
    puts " #{@board[3]}|#{@board[4]}|#{@board[5]}"
    puts ' ----- '.yellow
    puts " #{@board[6]}|#{@board[7]}|#{@board[8]}"
  end
end

# table = Board.new
# puts table.display_board
# puts table.board[3] = 'X'.blue
# puts table.display_board
