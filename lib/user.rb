require 'colorize'
class Player
  attr_reader :name, :value

  def initialize(name, value)
    @name = name
    @value = value
  end
end
