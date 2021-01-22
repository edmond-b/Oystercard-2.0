require 'oystercard'

describe Oystercard do
  describe '.journey' do
    it 'has empty list of journeys by default' do
      expect(subject.journeys).to be_empty
    end

    let(:journey){ {entry_station: entry_station, exit_station: exit_station} }
    let(:entry_station){ double :station }
    let(:exit_station){ double :station }
    it 'stores a journey' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include(journey)
    end
  end

  describe 'balance' do
    it 'has a default balance of 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '.top_up' do
    it 'responds to top_up' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it 'adds the amount to the current balance' do
      expect{ subject.top_up(10) }.to change{ subject.balance }.by(10)
    end

    it 'can not top up more than £90' do
      subject.top_up(Oystercard::MAX_BALANCE)
      expect{ subject.top_up(1) }.to raise_error("£#{Oystercard::MAX_BALANCE} limit reached")
    end
  end

  describe '.touch_in' do
    let(:station){ double :station }
    it 'remembers the entry station' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end

    it 'responds to touch_in' do
      expect(subject).to respond_to(:touch_in).with(1).argument
    end

    it 'changes the value of in_journey to true' do
      subject.top_up(10)
      expect { subject.touch_in(station) }.to change {subject.in_journey}.from(false).to(true)
    end

    it 'raises an error if not enough balance' do
      expect { subject.touch_in(station) }.to raise_error("Insufficient funds")
    end
  end

  describe 'touch_out' do
    let(:station){ double :station }
    it 'responds to touch_out' do
      expect(subject).to respond_to(:touch_out).with(1).argument
    end

    it 'remembers the exit station' do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.exit_station).to eq(station)
    end

    it 'changes the value of in_journey to false' do
      subject.top_up(10)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change {subject.in_journey}.from(true).to(false)
    end

    it 'charges min balance for journey on touch touch_out' do
      expect{ subject.touch_out(station) }.to change{ subject.balance }.by(-(Oystercard::MIN_BALANCE))
    end
  end

  describe '.journey' do
    it 'has a default value of false' do
      expect(subject.in_journey).to be_falsey
    end
  end
end
