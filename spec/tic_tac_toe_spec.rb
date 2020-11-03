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
      expect(game_ui.validating_value('X')).to eq('X')
    end

    it 'validate input diferen values than the X and O' do
      allow(game_ui).to receive(:gets).and_return('O')
      expect { game_ui.validating_value(' ') }.to output("Please enter X or O\n").to_stdout
    end

    it 'validate that the imput is between 1 to 9 or q' do
      expect(game_ui.numbers_validator(1)).to eq(1)
    end

    it 'validate that the imput is not between 1 to 9 or q' do
      allow(game_ui).to receive(:gets).and_return('9')
      expect { game_ui.numbers_validator(10) }.to output("Please enter a number between 1 to 9 or q\n").to_stdout
    end

    it 'validate Free spaces in the board' do
      expect(game_ui.entry_space_validator(board, 3)).to eq(3)
    end

    it 'validate Full space in the board' do
      allow(game_ui).to receive(:gets).and_return('1')
      expect { game_ui.entry_space_validator(board, 4) }.to output("That spot is taken chose again\n").to_stdout
    end

    it 'validate Player name no given' do
      allow(game_ui).to receive(:gets).and_return('name')
      expect { game_ui.validating_name('') }.to output("Please Provide a Name for the player\n").to_stdout
    end

    it 'validate Player name' do
      expect(game_ui.validating_name('player')).to eq('player')
    end

    it 'Returns the instructions ' do
      expect(game_ui.display_instructions).to eq(instructions)
    end

    it 'Display the board' do
      game_board.board = board
      expect { game_ui.display_board(game_board) }
        .to_not output("\t\t \n \t\t1|2|3 \n \t\t----- \n \t\tX|5|6 \n \t\t----- \n \t\t7|8|9 \n \t\t----- \n")
        .to_stdout
    end

    it 'provide players info' do
      allow(game_ui).to receive(:gets).and_return('player1', 'X', 'player2')
      game_board.board = %w[O X O
                            X O O
                            X X O]
      expect(game_ui.provide_players_info).to eq(true)
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
