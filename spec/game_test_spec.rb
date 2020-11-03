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

end
