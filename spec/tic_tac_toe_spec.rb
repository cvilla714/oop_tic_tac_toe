require_relative '../bin/main'

RSpec.describe 'An idial TIC TAC TOE game' do
  let(:title) { 'my title' }
  let(:instructions) { 'my instructions' }
  let(:game_board) { GameUi.new(title, instructions) }
  let(:board) { ['X', 2, 3, 4, 5, 6, 7, 8, 9] }
  describe 'The GameUi class ' do
    it 'lets me add a title ' do
      expect(game_board.display_title_on_screen).to eq(title)
    end

    it 'validate the X and O' do
      expect(game_board.validating_value('O')).to eq('O')
    end

    it 'validate that the imput is between 1 to 9 or q' do
      expect(game_board.numbers_validator(1)).to eq(1)
    end

    it 'validate Free spaces in the board' do
      expect(game_board.entry_space_validator(board, 3)).to eq(3)
    end

    it 'validate Player name' do
      expect(game_board.validating_name("Kender")).to eq("Kender")
    end

    it 'Returns the instructions ' do
      expect(game_board.display_instructions).to eq(instructions)
    end

  end
end
