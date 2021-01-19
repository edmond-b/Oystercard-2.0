require 'oystercard'

describe Oystercard do
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

  describe '.deduct' do
    it 'responds to deduct' do
      expect(subject).to respond_to(:deduct).with(1).argument
    end

    it 'deducts the amount from balance' do
      subject.top_up(10)
      expect{ subject.deduct(5) }.to change{ subject.balance }.by(-5)
    end
  end

  describe '.touch_in' do
    it 'responds to touch_in' do
      expect(subject).to respond_to(:touch_in)
    end

    it 'changes the value of in_journey to true' do
      subject.top_up(10)
      expect { subject.touch_in }.to change {subject.in_journey}.from(false).to(true)
    end

    it 'raises an error if not enough balance' do
      expect { subject.touch_in }.to raise_error("Insufficient funds")
    end
  end

  describe 'touch_out' do
    it 'responds to touch_out' do
      expect(subject).to respond_to(:touch_out)
    end

    it 'changes the value of in_journey to false' do
      subject.top_up(10)
      subject.touch_in
      expect { subject.touch_out }.to change {subject.in_journey}.from(true).to(false)
    end
  end

  describe '.journey' do
    it 'has a default value of false' do
      expect(subject.in_journey).to be_falsey
    end
  end
end
