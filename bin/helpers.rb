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
end

# value1 = gets.chomp
# p AuthenticatingValues.numbers_validator(value1)
