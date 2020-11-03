require_relative '../bin/main.rb'

RSpec.describe GameUi do
  let(:noto) { GameUi.new('title', 'instructions') }
  #   let(:title) { display_title_on_screen }
  #   let(:instructions) { display_instructions }

  it 'check if the title is displayed' do
    expect(noto.title).to eq('title')
  end
end
