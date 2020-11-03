require_relative '../bin/main'
require_relative '../lib/user'
require_relative '../lib/logic'

RSpec.describe 'An idial TIC TAC TOE game' do
  let(:title) { 'my title' }
  let(:instructions) { 'my instructions' }
  let(:game_board) { Board.new }
  let(:game_ui) { GameUi.new(title, instructions) }
  let(:board) { [1, 2, 3, 'X', 5, 6, 7, 8, 9] }
  describe 'The GameUi class ' do
    it 'lets me add a title ' do
      expect(game_ui.display_title_on_screen).to eq(title)
    end

    it 'validate the X and O' do
      allow(game_ui).to receive(:gets).and_return('O')
      expect { game_ui.validating_value(' ') }.to output("Please enter X or O\n").to_stdout
    end

    it 'validate that the imput is between 1 to 9 or q' do
      expect(game_ui.numbers_validator(1)).to eq(1)
    end

    it 'validate Free spaces in the board' do
      expect(game_ui.entry_space_validator(board, 3)).to eq(3)
    end

    it 'validate Full space in the board' do
      allow(game_ui).to receive(:gets).and_return('1')
      expect { game_ui.entry_space_validator(board, 4) }.to output("That spot is taken chose again\n").to_stdout
    end

    it 'validate Player name' do
      allow(game_ui).to receive(:gets).and_return('name')
      expect { game_ui.validating_name('') }.to output("Please Provide a Name for the player\n").to_stdout
    end

    it 'Returns the instructions ' do
      expect(game_ui.display_instructions).to eq(instructions)
    end
  end

  describe 'The Game logic ' do
    let(:player_1) { Player.new('Kender', 'O') }
    it 'Aunthenticating winner' do
      game_board.board = %w[O X O
                            X O O
                            X X O]
      expect(AuthenticatingValues.authenticating_winner(game_board, player_1)).to eq(true)
    end
    it 'Aunthenticating Draw' do
      game_board.board = %w[X X O
                            O O X
                            X O X]
      expect(AuthenticatingValues.authenticating_winner(game_board, player_1)).to eq(false)
    end
  end
end
