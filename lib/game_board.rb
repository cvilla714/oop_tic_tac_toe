require 'colorize'
class Board
  attr_accessor :board
  attr_reader :winner

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
end
