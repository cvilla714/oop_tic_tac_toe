#!/usr/bin/env ruby
# rubocop:disable Metrics/MethodLength
require 'colorize'
require_relative '../lib/user'
require_relative '../lib/logic'
require_relative '../lib/game_board'
class GameUi
  attr_reader :title, :instructions

  SELECTION = %w[X O].freeze
  NUMBERS_RANGES = (1..9).freeze

  def initialize(title, instructions)
    @title = title
    @instructions = instructions
  end

  def display_title_on_screen
    title
  end

  def validating_value(choice)
    until SELECTION.any?(choice)
      puts 'Please enter X or O'
      choice = gets.chomp
    end
    choice
  end

  def numbers_validator(choice)
    until NUMBERS_RANGES.any?(choice.to_i) || choice == 'q'
      puts 'Please enter a number between 1 to 9 or q'
      choice = gets.chomp
    end
    choice
  end

  def entry_space_validator(board, value)
    option = false
    until option
      if value == board[value - 1]
        option = true
      else
        puts 'That spot is taken chose again'
        new_input = gets.chomp
        value = new_input.to_i
        option = false
      end
    end
    value
  end

  def validating_name(player_name)
    while player_name =~ /\A\s*\Z/
      puts 'Please Provide a Name for the player'
      player_name = gets.chomp
    end
    player_name
  end

  def provide_players_info
    puts 'Please provide the name for Player1: '
    player1_name = gets.chomp
    player1_name = validating_name(player1_name)
    puts 'Please choose between X or O '
    player1_value = gets.chomp
    player1_value = validating_value(player1_value.upcase)
    puts 'Please provide the name for Player2: '
    player2_name = gets.chomp
    player2_name = validating_name(player2_name)
    player2_value = player1_value == 'O' ? 'X' : 'O'
    player1 = Player.new(player1_name, player1_value.yellow)
    player2 = Player.new(player2_name, player2_value.blue)
    players_list = [player1, player2]
    puts "player #{player2.name.green} choose #{player2.value.yellow}"
    players_turn(players_list)
    true
  end

  def display_instructions
    instructions
  end

  def display_board(table)
    puts "\t\t \n".yellow +
         " \t\t#{table.board[0]}|#{table.board[1]}|#{table.board[2]} \n" +
         " \t\t----- \n".yellow +
         " \t\t#{table.board[3]}|#{table.board[4]}|#{table.board[5]} \n" +
         " \t\t----- \n".yellow +
         " \t\t#{table.board[6]}|#{table.board[7]}|#{table.board[8]} \n" +
         " \t\t----- \n".yellow
    table.board
  end

  def players_turn(players_list)
    draw = false
    table = Board.new
    display_board(table)
    8.downto(0) do |space|
      user_id = space.odd? ? 1 : 0
      puts "Please player #{players_list[user_id].name.green} choose a number from the grid 1 to 9 or q to exit."
      input_user = gets.chomp
      input_user = numbers_validator(input_user)
      puts "Player #{players_list[user_id].name.green} there are only #{space} spaces left \n\n"
      if input_user == 'q'
        puts 'Quiting game...'.red
        return nil
      end
      empty_space = entry_space_validator(table.board, input_user.to_i)
      table.board[empty_space.to_i - 1] = players_list[user_id].value unless input_user == 'q'
      winner = AuthenticatingValues.authenticating_winner(table, players_list[user_id])
      display_board(table)
      if winner
        draw = winner
        puts "Congratulatios #{players_list[user_id].name} you Won!!".green
        break
      end
      draw = winner
    end
    puts "It's a draw!".red + '  GAME OVER'.light_blue unless draw
  end
end

if __FILE__ == $PROGRAM_NAME
  game_ui = GameUi.new("\t\t\t\t*****TIC TAC TOE*******\n\n\n",
                       "**for two players, X and O, who take turns marking the spaces in a 3times3 grid.
  The player who succeeds in placing three of their marks in a horizontal, vertical,
  or diagonal row is the winner. It is a solved game with a forced draw assuming best play
  from both players.**\n\n\n")

  puts game_ui.display_title_on_screen
  puts game_ui.display_instructions
  game_ui.provide_players_info
end
# rubocop:enable Metrics/MethodLength
