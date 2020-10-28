module AuthenticatingValues
  def self.authenticating_winner(board, player)
    board.winner.each do |item|
      next unless board.board[item[0]] == player.value &&
                  board.board[item[1]] == player.value &&
                  board.board[item[2]] == player.value

      return true
    end
    false
  end
end
