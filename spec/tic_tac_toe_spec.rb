require_relative '../bin/main'
require_relative '../lib/user'
require_relative '../lib/logic'

RSpec.describe 'An idial TIC TAC TOE game' do
  let(:title) { 'my title' }
  let(:instructions) { 'my instructions' }
  let(:game_board) { Board.new }
  let(:player_1) { Player.new('Kender', 'O') }
  let(:game_ui) { GameUi.new(title, instructions) }
  let(:game_ui_no_instructions) { GameUi.new(title) }
  let(:game_ui_no_title) { GameUi.new(nil, instructions) }
  let(:board) { [1, 2, 3, 'X', 5, 6, 7, 8, 9] }
  describe 'The GameUi class ' do
    describe '#display_instructions' do
      context 'when title is provided' do
        it 'lets me add a title' do
          expect(game_ui.display_title_on_screen).to eq(title)
        end
      end

      context 'when title is not provided' do
        it 'when there is no title' do
          expect(game_ui_no_title.display_title_on_screen).to eq('No title')
        end
      end
    end

    describe '#validating_value' do
      context 'When the player inputs the right value' do
        it 'validate the X and O' do
          expect(game_ui.validating_value('X')).to eq('X')
        end
      end

      context 'When the player inputs the wrong value' do
        before do
          allow(game_ui).to receive(:gets).and_return('O')
        end
        it 'validate input differences values than the X and O' do
          expect { game_ui.validating_value(' ') }.to output("Please enter X or O\n").to_stdout
        end
      end
    end

    describe '#numbers_validator' do
      context 'When the player inputs the right number' do
        it 'validate that the input is between 1 to 9 or q' do
          expect(game_ui.numbers_validator(1)).to eq(1)
        end
      end

      context 'When the player inputs the wrong number' do
        before do
          allow(game_ui).to receive(:gets).and_return('9')
        end
        it 'validate that the input is not between 1 to 9 or q' do
          expect { game_ui.numbers_validator(10) }.to output("Please enter a number between 1 to 9 or q\n").to_stdout
        end
      end
    end

    describe '#entry_space_validator' do
      context 'When player enters number on a free space' do
        it 'validate Free spaces in the board' do
          expect(game_ui.entry_space_validator(board, 3)).to eq(3)
        end
      end

      context 'validate Full space in the board' do
        before do
          allow(game_ui).to receive(:gets).and_return('1')
        end
        it 'does not include the display name' do
          expect { game_ui.entry_space_validator(board, 4) }.to output("That spot is taken chose again\n").to_stdout
        end
      end
    end

    describe '#validating_name' do
      context 'when player has provided a name' do
        it 'validate Player name' do
          expect(game_ui.validating_name('player')).to eq('player')
        end
      end

      context 'when player has not provided a name' do
        before do
          allow(game_ui).to receive(:gets).and_return('name')
        end
        it 'does not include the display name' do
          expect { game_ui.validating_name('') }.to output("Please Provide a Name for the player\n").to_stdout
        end
      end
    end

    describe '#display_instructions' do
      context 'when instructions are provided' do
        it 'displays the instructions' do
          expect(game_ui.display_instructions).to eq(instructions)
        end
      end

      context 'when instructions are not provided' do
        it 'does not display the instructions' do
          expect(game_ui_no_instructions.display_instructions).to eq('No instructions')
        end
      end
    end

    it 'Display the board' do
      game_board.board = board
      expect { game_ui.display_board(game_board) }
        .to output("\t\t \n \t\t1|2|3 \n \t\t----- \n \t\tX|5|6 \n \t\t----- \n \t\t7|8|9 \n \t\t----- \n")
        .to_stdout
    end

    it 'ask for a player name' do
      allow(game_ui).to receive(:gets).and_return('name')
      expect { game_ui.ask_player_for_name(1) }.to output("Please provide the name for Player1: \n").to_stdout
    end

    it 'ask for a player value' do
      allow(game_ui).to receive(:gets).and_return('name')
      expect { game_ui.ask_player_for_value }.to output("Please choose between X or O \n").to_stdout
    end

    it 'display player choice' do
      expect { game_ui.display_player_choice(player_1) }
        .to output("player \e[0;32;49mKender\e[0m choose \e[0;33;49mO\e[0m\n").to_stdout
    end

    it 'ask player to fill board' do
      allow(game_ui).to receive(:gets).and_return('1')
      expect { game_ui.ask_player_to_fill_board(player_1.name) }
        .to output("Please player \e[0;32;49mKender\e[0m choose a number from the grid 1 to 9 or q to exit.\n")
        .to_stdout
    end

    it 'display empty space to the player' do
      expect { game_ui.display_enty_space(player_1.name, 8) }
        .to output("Player #{player_1.name} there are only 8 spaces left \n\n")
        .to_stdout
    end
  end

  describe 'The Game logic ' do
    context 'when the game has a Winner' do
      before do
        game_board.board = %w[O X O
                              X O O
                              X X O]
      end
      it 'Aunthenticating winner' do
        expect(AuthenticatingValues.authenticating_winner(game_board, player_1)).to eq(true)
      end
    end

    context 'when the game is a Draw' do
      before do
        game_board.board = %w[X X O
                              O O X
                              X O X]
      end
      it 'Aunthenticating Draw' do
        expect(AuthenticatingValues.authenticating_winner(game_board, player_1)).to eq(false)
      end
    end
  end
end
