require 'oystercard'

describe Oystercard do
  it 'has a default balance of 0' do
    expect(subject.balance).to eq(0)
  end

  describe '.top_up' do
    it 'responds to top_up' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it 'adds the amount to the current balance' do
      expect { subject.top_up(10) }.to change { subject.balance }.by(10)
    end

    it 'can not top up more than £90' do
      subject.top_up(Oystercard::MAX_BALANCE)
      expect { subject.top_up(1) }.to raise_error("£#{Oystercard::MAX_BALANCE} limit reached")
    end
  end
end
