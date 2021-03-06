# frozen_string_literal: true

require_relative '../lib/oystercard'


describe OysterCard do

  let(:initial_balance) { 1 }

  let(:entry_station) { double(:station, :name => "Holborn") }
  let(:exit_station) { double(:station, :name => "Liverpool Street") }


  # let(:journey) { double(:journey, :entry_station => entry_station, :exit_station => exit_station) }
  # let(:journey_class) { double(:journey_class, :new => journey)}

  let(:journey) { Journey.new(entry_station, exit_station) }
  let(:journey_class) { double(:journey_class, :new => journey, :calculate_fare => 1) }


  subject(:oyster_card) { described_class.new(journey_class) }

  describe 'initialisation' do

    it { is_expected.to respond_to(:balance) }

    it 'has a default balance of zero when initialized' do
      expect(oyster_card.balance).to eq 0
    end

    it 'has a balance of 1 when initialized with balance = 1 ' do
      oyster_card = described_class.new(journey_class, initial_balance)
      expect(oyster_card.balance).to eq 1
    end

    it 'has an empty list of journeys' do
      oyster_card = described_class.new(journey_class, initial_balance)
      expect(oyster_card.journeys).to be_empty
    end

    
  
  end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'adds money to the balance of the card' do
      expect{ oyster_card.top_up (1) }.to change{ oyster_card.balance }.by 1
    end

    it "raises an error when balance limit is exceeded on top_up" do
        expect { oyster_card.top_up(described_class::BALANCE_LIMIT + 1) }.to raise_error "Cannot exceed a balance of £#{described_class::BALANCE_LIMIT}"
    end

  end

  # describe '#in_journey?' do
  #   it { is_expected.to respond_to(:in_journey?) }
  # end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in).with(1).argument }

    # it "starts a journey" do
    #   oyster_card.top_up(1)
    #   oyster_card.touch_in(entry_station)
    #   expect(oyster_card).to be_in_journey
    # end

    it "raises error with insufficient funds" do
      expect{oyster_card.touch_in(entry_station)}.to raise_error "Insufficient funds on card"
    end

    # it "stores the entry station" do
    #   oyster_card.top_up(1)
    #   oyster_card.touch_in(entry_station)
    #   expect(oyster_card.current_journey.entry_station).to eq entry_station
    # end

    let(:journey) { Journey.new }
    let(:journey_class) { double(:journey_class, :new => journey) }

    it "deduct the balance if a penalty is applied due to not touching out on a journey" do

      oyster_card.top_up(6)
      oyster_card.touch_in(entry_station)

      allow(journey).to receive(:calculate_fare).and_return(6)

      oyster_card.touch_in(entry_station)
      expect(oyster_card.balance).to eq 0
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out) }

    # it "ends a journey" do
    #   allow(journey).to receive(:exit_station).and_return(exit_station)
    #   oyster_card.top_up(1)
    #   oyster_card.touch_in(entry_station)
    #   oyster_card.touch_out(exit_station)
    #   expect(oyster_card).to_not be_in_journey
    # end

    it "changes the value of the balance" do
      oyster_card.top_up(1)
      oyster_card.touch_in(entry_station)
      expect{ oyster_card.touch_out(exit_station) }.to change{ oyster_card.balance }.by -described_class::MINIMUM_FARE
    end
    
    it "clears the entry_station" do
      oyster_card.top_up(1)
      oyster_card.touch_in(entry_station)
      oyster_card.touch_out(exit_station)
      expect( oyster_card.entry_station ).to be_nil
    end

    it "creates a journey at the end of a journey" do
      oyster_card.top_up(1)
      oyster_card.touch_in(entry_station)
      oyster_card.touch_out(exit_station)
      expect( oyster_card.journeys).to eq [journey]
    end

    it "creates multiple journeys" do
      oyster_card.top_up(10) 
      oyster_card.touch_in(entry_station)
      oyster_card.touch_out(exit_station)
      oyster_card.touch_in(entry_station)
      oyster_card.touch_out(exit_station)
      expect( oyster_card.journeys).to eq [journey,journey]
    end

  end
  
end
