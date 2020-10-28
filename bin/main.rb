#!/usr/bin/env ruby
require 'colorize'
require_relative 'user'
require_relative 'helpers'
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
    player1_value = AuthenticatingValues.validating_value(player1_value)
    # puts player1_value
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

  def display_gameboard
    puts ' 1|2|3'.yellow
    puts ' ----- '.yellow
    puts ' 4|5|6'.yellow
    puts ' ----- '.yellow
    puts ' 7|8|9'.yellow
  end

  # private

  # def display_info(players)
  #   counter = 0
  #   players.each do |key, value|
  #     puts "player#{counter += 1} #{key} choose #{value}"
  #   end
  # end

  public

  def players_turn(players_list)
    8.downto(0) do |space|
      user_id = space.odd? ? 1 : 0
      display_gameboard
      puts "Please player #{players_list[user_id].name.green} choose a number from the grid 1 to 9 or q to exit."
      input_user = gets.chomp
      puts "Player #{players_list[user_id].name.green} there are only #{space} spaces left \n\n"
      display_invalid_move
      if input_user == 'q'
        puts 'GAME OVER'.light_blue
        return 'Game Over'
      end
    end
    display_final_results('win', players_list[0].name)
    display_final_results(nil)
    puts 'GAME OVER'.light_blue
  end

  def display_final_results(value, player_name = ' ')
    if value == 'win'
      puts "#{player_name} Congrats you won!!"
    else
      puts "It's a tie!"
    end
  end

  def display_invalid_move
    puts 'That selection was already made'
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
