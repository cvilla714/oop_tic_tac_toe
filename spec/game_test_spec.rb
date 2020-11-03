require_relative '../bin/main.rb'

RSpec.describe GameUi do
  let(:maintitle) { GameUi.new('title', 'instructions') }
  let(:notitle) { GameUi.new(nil, 'instructions') }
  let(:noinstuctions) { GameUi.new('title', 'No instructions') }
  #   let(:firstplayer) { Player.new.ask_player_for_name('name', value) }

  it 'check if the title is displayed' do
    expect(maintitle.title).to eq('title')
  end

  context "when you don't have a title" do
    it 'check if the title is not displayed' do
      expect(notitle.title).to eq('No title')
    end
  end

  describe 'when instructions are displayed' do
    it 'check if the instructions are shown' do
      expect(maintitle.instructions).to eq('instructions')
    end

    context 'when no instructions are shown' do
      it 'will check if no instructions are available' do
        expect(noinstuctions.instructions).to eq('No instructions')
      end
    end
  end
  context 'asking for the player value' do
    it 'will ask for the value for the first player' do
      allow(maintitle).to receive(:gets).and_return('name')
      expect { maintitle.ask_player_for_value }.to output("Please choose between X or O \n").to_stdout
    end
  end
  describe 'ask the name for the second player' do
    it 'will ask the second player for their name' do
      allow(maintitle).to receive(:gets).and_return('name')
      expect { maintitle.ask_player_for_name(2) }.to output("Please provide the name for Player2: \n").to_stdout
    end
  end
  describe 'validate the selection made by the first player' do
    it 'validate the choice made' do
      expect(maintitle.validating_value('X')).to eq('X')
    end
  end
  context 'validate if they inmput the wrong choice' do
    it 'will validate if they provide the wrong input' do
      allow(maintitle).to receive(:gets).and_return('X')
      expect { maintitle.validating_value('K') }.to output("Please enter X or O\n").to_stdout
    end
  end
  
end
