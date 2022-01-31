# frozen_string_literal: true

require_relative '../lib/oystercard'

describe OysterCard do
  subject(:oyster_card) { described_class.new }

  describe '#balance' do
    let(:initialise_balance) { 1 }

    it { is_expected.to respond_to(:balance) }

    it 'has a default balance of zero when initialized' do
      expect(oyster_card.balance).to eq 0
    end

    it 'has a balance of 1 when initialized with balance = 1 ' do
      oyster_card = described_class.new(initialise_balance)
      expect(oyster_card.balance).to eq 1
    end
  end

  describe '#top_up' do

    let(:initialise_balance) { 1 }
    
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'should add money to the balance of the card' do
      expect{ oyster_card.top_up (1) }.to change{ oyster_card.balance }.by 1
    end

    it 'should add money to the balance of the card when not using default balance' do
      oyster_card = described_class.new(initialise_balance)
      expect{ oyster_card.top_up (1) }.to change{ oyster_card.balance }.by 1
    end

  end
end
