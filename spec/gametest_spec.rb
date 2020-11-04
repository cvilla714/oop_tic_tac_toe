require_relative '../bin/main.rb'
require_relative '../lib/game_board'
require_relative '../lib/logic'
require_relative '../lib/user'

RSpec.shared_context 'common' do
  let(:player1) { Player.new('Ali', 'X') }
  let(:maintitle) { GameUi.new('title', 'instructions') }
end

RSpec.describe GameUi do
  subject { described_class.new('title', 'instructions') }
  let(:notitle) { described_class.new(nil, 'instructions') }
  let(:noinstuctions) { described_class.new('title', 'No instructions') }

  it 'check if the title is displayed' do
    expect(subject.title).to eq('title')
  end

  context "when you don't have a title" do
    it 'check if the title is not displayed' do
      expect(notitle.title).to eq('No title')
    end
  end

  describe 'when instructions are displayed' do
    it 'check if the instructions are shown' do
      expect(subject.instructions).to eq('instructions')
    end

    context 'when no instructions are shown' do
      it 'will check if no instructions are available' do
        expect(noinstuctions.instructions).to eq('No instructions')
      end
    end
  end

  describe 'asking for the players name' do
    it 'will check for the name of the first player' do
      allow(subject).to receive(:gets).and_return('name')
      expect { subject.ask_player_for_name(1) }.to output("Please provide the name for Player1: \n").to_stdout
    end
  end

  context 'asking for the player value' do
    it 'will ask for the value for the first player' do
      allow(subject).to receive(:gets).and_return('name')
      expect { subject.ask_player_for_value }.to output("Please choose between X or O \n").to_stdout
    end
  end

  describe 'ask the name for the second player' do
    it 'will ask the second player for their name' do
      allow(subject).to receive(:gets).and_return('name')
      expect { subject.ask_player_for_name(2) }.to output("Please provide the name for Player2: \n").to_stdout
    end
  end

  describe 'validate the selection made by the first player' do
    it 'validate the choice made' do
      expect(subject.validating_value('X')).to eq('X')
    end
  end

  context 'validate if they inmput the wrong choice' do
    it 'will validate if they provide the wrong input' do
      allow(subject).to receive(:gets).and_return('X')
      expect { subject.validating_value('K') }.to output("Please enter X or O\n").to_stdout
    end
  end

  describe 'validated the number from 1 to 9' do
    it 'will validate the number selection from 1 to 9' do
      expect(subject.numbers_validator(5)).to eq(5)
    end
  end

  context 'validate the wrong number selection' do
    it 'will check if the user input the wrong number' do
      allow(subject).to receive(:gets).and_return('5')
      expect { subject.numbers_validator(10) }.to output("Please enter a number between 1 to 9 or q\n").to_stdout
    end
  end

  describe 'validate the names the players are given' do
    it 'will check for empty spaces for the players names' do
      allow(subject).to receive(:gets).and_return('name')
      expect { subject.validating_name('  ') }.to output("Please Provide a Name for the player\n").to_stdout
    end
  end

  context 'validate the name of the player' do
    it 'will check the player has provided a valid name' do
      expect(subject.validating_name('Ali')).to eq('Ali')
    end
  end
end

RSpec.describe Board do
  include_context 'common'

  describe 'check if the board is displayed' do
    it 'will check if the board will display to the players' do
      expect { maintitle.display_board(subject) }.to output("\t\t \n \t\t1|2|3 \n \t\t----- \n \t\t4|5|6 \n \t\t----- \n \t\t7|8|9 \n \t\t----- \n").to_stdout
    end
  end
  context 'matching a winning combination' do
    before(:example) do
      subject.board = %w[X O X O X O X O O]
    end
    it 'match the winning combo' do
      expect(AuthenticatingValues.authenticating_winner(subject, player1)).to eq(true)
    end
    context 'matich a draw combination' do
    before(:example) do
      subject.board = %w[X X O O O X X X O]
    end
    it 'will match for the draw' do
      expect(AuthenticatingValues.authenticating_winner(subject, player1)).to eq(false)
    end
  end
 end
end
