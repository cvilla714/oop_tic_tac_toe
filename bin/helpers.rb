module AuthenticatingValues
  SELECTION = %w[X O].freeze
  NUMBERS_RANGES = (1..9).freeze

  def self.validating_value(choice)
    until SELECTION.any?(choice.upcase!)
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
end

# board = ["x", 2, 3, 4, 5, 6, 7, 8, 9]
# p AuthenticatingValues.entry_space_validator(board, 1)