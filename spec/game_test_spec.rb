require_relative '../bin/main.rb'

RSpec.describe GameUi do
  let(:maintitle) { GameUi.new('title', 'instructions') }
  let(:notitle) { GameUi.new(nil, 'instructions') }

  it 'check if the title is displayed' do
    expect(maintitle.title).to eq('title')
  end

     context "when you don't have a title" do
     it 'check if the title is not displayed' do
       expect(notitle.title).to eq('No title')
        end
    end
end
