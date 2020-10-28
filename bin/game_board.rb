require 'colorize'
class Board
  attr_reader :board, :winner
  attr_writer :board

  def initialize
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @winner = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]
  end

  def display_board
    puts " \t\t \n".yellow
    puts " \t\t#{@board[0]}|#{@board[1]}|#{@board[2]}"
    puts " \t\t----- ".yellow
    puts " \t\t#{@board[3]}|#{@board[4]}|#{@board[5]}"
    puts " \t\t----- ".yellow
    puts " \t\t#{@board[6]}|#{@board[7]}|#{@board[8]}"
    puts " \t\t----- \n".yellow
  end
end

# table = Board.new
# puts table.display_board
# puts table.board[3] = 'X'.blue
# puts table.display_board

# table = Board.new
# puts table.display_board
# puts table.board[7] = 'O'.blue
# puts table.display_board
