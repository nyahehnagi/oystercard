# frozen_string_literal: true

require_relative '../lib/oystercard'

describe OysterCard do
  subject(:oyster_card) { described_class.new }
  let(:initial_balance) { 1 }
  let(:station) { double(:station, :name => "Holborn") }

  describe 'initialisation' do

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

    it "should raise an error when balance limit is exceeded on top_up" do
        expect { oyster_card.top_up(described_class::BALANCE_LIMIT + 1) }.to raise_error "Cannot exceed a balance of £#{described_class::BALANCE_LIMIT}"
    end

  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?) }
  end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it "should start a journey" do
      oyster_card = described_class.new(initial_balance)
      oyster_card.touch_in(station)
      expect(oyster_card).to be_in_journey
    end

    it "raises error with insufficient funds" do
      expect{oyster_card.touch_in(station)}.to raise_error "Insufficient funds on card"
    end

    it "should store the entry station" do
      oyster_card = described_class.new(initial_balance)
      oyster_card.touch_in(station)
      expect(oyster_card.entry_station.name).to eq station.name
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out) }

    it "should end a journey" do
      oyster_card = described_class.new(initial_balance)
      oyster_card.touch_in(station)
      oyster_card.touch_out
      expect(oyster_card).to_not be_in_journey
    end

    it "should change the value of the balance" do
      oyster_card = described_class.new(initial_balance)
      oyster_card.touch_in(station)
      expect{ oyster_card.touch_out }.to change{ oyster_card.balance }.by -described_class::MINIMUM_FARE
    end
    
    it "should clear the entry_station" do
      oyster_card = described_class.new(initial_balance)
      oyster_card.touch_in(station)
      oyster_card.touch_out
      expect( oyster_card.entry_station ).to be_nil
    end
  end
  
end
