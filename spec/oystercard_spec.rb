require_relative '../lib/oystercard'

describe OysterCard do
  
  subject(:card) { described_class.new() }

  describe '#balance' do
    let(:initialise_balance) {1}

    it { is_expected.to respond_to(:balance) }
    
    it "has a default balance of zero when initialized" do
      expect(card.balance).to eq 0
    end

    it "has a balance of 1 when initialized with balance = 1 " do
      card = described_class.new(:initialise_balance)
      expect(card.balance).to eq :initialise_balance
    end

  end
end