#!/usr/bin/env ruby
# rubocop:disable Metrics/MethodLength
require 'colorize'
module AuthenticatingValues
  SELECTION = %w[X O].freeze
  NUMBERS_RANGES = (1..9).freeze

  def self.validating_value(choice)
    until SELECTION.any?(choice)
      puts 'Please enter X or O'
      choice = gets.chomp
    end
    choice
  end

  def self.numbers_validator(choice)
    until NUMBERS_RANGES.any?(choice.to_i) || choice == 'q'
      puts 'Please enter a number between 1 to 9 or q'
      choice = gets.chomp
    end
    choice
  end

  def self.entry_space_validator(board, value)
    option = false
    until option
      if value == board[value - 1]
        option = true
      else
        puts 'That spot is taken chose again'.red
        new_input = gets.chomp
        value = new_input.to_i
        option = false
      end
    end
    value
  end

  def self.authenticating_winner(board, player)
    board.winner.each do |item|
      next unless board.board[item[0]] == player.value &&
                  board.board[item[1]] == player.value &&
                  board.board[item[2]] == player.value

      puts "Congratulatios #{player.name} you Won!!".green
      return true
    end
    false
  end
end

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

class Player
  attr_reader :name, :value

  def initialize(name, value)
    @name = name
    @value = value
  end

  def show_players_info
    puts "player #{@name.green} choose #{@value.yellow}"
  end
end

class GameUi
  attr_reader :title, :instructions

  def initialize(title, instructions)
    @title = title
    @instructions = instructions
  end

  def display_title_on_screen
    puts title
  end

  def provide_players_info
    puts 'Please provide the name for Player1: '
    player1_name = gets.chomp
    puts 'Please choose between X or O '
    player1_value = gets.chomp
    player1_value = AuthenticatingValues.validating_value(player1_value.upcase)
    puts 'Please provide the name for Player2: '
    player2_name = gets.chomp
    player2_value = player1_value == 'O' ? 'X' : 'O'
    player1 = Player.new(player1_name, player1_value)
    player2 = Player.new(player2_name, player2_value)
    players_list = [player1, player2]
    player2.show_players_info
    players_turn(players_list)
  end

  def display_instructions
    puts instructions
  end

  def players_turn(players_list)
    draw = false
    table = Board.new
    table.display_board
    8.downto(0) do |space|
      user_id = space.odd? ? 1 : 0
      puts "Please player #{players_list[user_id].name.green} choose a number from the grid 1 to 9 or q to exit."
      input_user = gets.chomp
      input_user = AuthenticatingValues.numbers_validator(input_user)
      puts "Player #{players_list[user_id].name.green} there are only #{space} spaces left \n\n"
      if input_user == 'q'
        puts 'GAME OVER'.light_blue
        return 'Game Over'
      end
      empty_space = AuthenticatingValues.entry_space_validator(table.board, input_user.to_i)
      table.board[empty_space.to_i - 1] = players_list[user_id].value unless input_user == 'q'
      winner = AuthenticatingValues.authenticating_winner(table, players_list[user_id])
      table.display_board
      if winner
        draw = winner
        break
      end
      draw = winner
    end
    puts "It's a draw!".red unless draw
    puts 'GAME OVER'.light_blue
  end
end

game_ui = GameUi.new("\t\t\t\t*****TIC TAC TOE*******\n\n\n",
                     "**for two players, X and O, who take turns marking the spaces in a 3×3 grid.
The player who succeeds in placing three of their marks in a horizontal, vertical,
or diagonal row is the winner. It is a solved game with a forced draw assuming best play
from both players**\n\n\n")

game_ui.display_title_on_screen
game_ui.display_instructions
game_ui.provide_players_info
# rubocop:enable Metrics/MethodLength
