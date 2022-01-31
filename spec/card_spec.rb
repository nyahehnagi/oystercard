require_relative '../lib/card'

describe Card do

  describe '#balance' do

    it { is_expected.to respond_to(:balance) }
    
    it "has a balance of zero when initialized" do
      expect(subject.balance).to eq 0
    end

    it "has a balance of 1 when initialized" do
      card = Card.new(1)
      expect(card.balance).to eq 1
    end

  end
end