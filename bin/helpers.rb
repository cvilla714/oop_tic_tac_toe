module AuthenticatingValues
  SELECTION = %w[X O].freeze
  def self.validating_value(choice)
    until SELECTION.any?(choice.upcase!)
      puts 'Please enter X or O'
      choice = gets.chomp
    end
    choice
  end
end

# value1 = gets.chomp
# p AuthenticatingValues.validating_value(value1)
