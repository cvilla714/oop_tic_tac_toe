require 'colorize'
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

