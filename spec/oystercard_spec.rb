# frozen_string_literal: true

require_relative '../lib/oystercard'

describe OysterCard do
  subject(:oyster_card) { described_class.new }
  let(:initial_balance) { 1 }

  describe '#balance' do

    it { is_expected.to respond_to(:balance) }

    it 'has a default balance of zero when initialized' do
      expect(oyster_card.balance).to eq 0
    end

    it 'has a balance of 1 when initialized with balance = 1 ' do
      oyster_card = described_class.new(initial_balance)
      expect(oyster_card.balance).to eq 1
    end
  end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'should add money to the balance of the card' do
      expect{ oyster_card.top_up (1) }.to change{ oyster_card.balance }.by 1
    end

    it 'should add money to the balance of the card when not using default balance' do
      oyster_card = described_class.new(initial_balance)
      expect{ oyster_card.top_up (1) }.to change{ oyster_card.balance }.by 1
    end

    it "should raise an error when balance limit is exceeded on top_up" do
        expect { oyster_card.top_up(described_class::BALANCE_LIMIT + 1) }.to raise_error "Cannot exceed a balance of £#{described_class::BALANCE_LIMIT}"
    end

  end

  describe "#deduct_fare" do
    it { is_expected.to respond_to(:deduct_fare).with(1).argument }

    it "should deduct the amount from the card balance" do
      oyster_card = described_class.new(initial_balance)
      expect { oyster_card.deduct_fare(1) }.to change{ oyster_card.balance }.by -1
    end

  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?) }
  end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in) }

    it "should start a journey" do
      oyster_card = described_class.new(initial_balance)
      oyster_card.touch_in
      expect(oyster_card).to be_in_journey
    end

    it "raises error with insufficient funds" do
      expect{oyster_card.touch_in}.to raise_error "Insufficient funds on card"
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out) }

    it "should end a journey" do
      oyster_card = described_class.new(initial_balance)
      oyster_card.touch_in
      oyster_card.touch_out
      expect(oyster_card).to_not be_in_journey
    end
  end
  
end
