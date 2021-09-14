require 'rails_helper'

describe Poker::Card do
  describe '#==' do
    it 'should support equality based on rank and suit' do
      %w[2 3 4 5 6 7 8 9 T J Q K A].each do |rank|
        %w[C D H S].each do |suit|
          expect(Poker::Card.new("#{rank}#{suit}")).to eq(Poker::Card.new("#{rank}#{suit}"))
        end
      end

      expect(Poker::Card.new('2C')).not_to eq(Poker::Card.new('3C'))
      expect(Poker::Card.new('2C')).not_to eq(Poker::Card.new('2H'))
    end
  end

  describe '#value' do
    it 'should be integer representing numeric value of card rank' do
      expect(Poker::Card.new('2C').value).to eq(0)
      expect(Poker::Card.new('3C').value).to eq(1)
      expect(Poker::Card.new('4C').value).to eq(2)
      expect(Poker::Card.new('5C').value).to eq(3)
      expect(Poker::Card.new('6C').value).to eq(4)
      expect(Poker::Card.new('7C').value).to eq(5)
      expect(Poker::Card.new('8C').value).to eq(6)
      expect(Poker::Card.new('9C').value).to eq(7)
      expect(Poker::Card.new('TC').value).to eq(8)
      expect(Poker::Card.new('JC').value).to eq(9)
      expect(Poker::Card.new('QC').value).to eq(10)
      expect(Poker::Card.new('KC').value).to eq(11)
      expect(Poker::Card.new('AC').value).to eq(12)
    end
  end

  describe '#rank' do
    it 'should be symbol represention of card rank identity' do
      expect(Poker::Card.new('2C').rank).to eq(:two)
      expect(Poker::Card.new('3C').rank).to eq(:three)
      expect(Poker::Card.new('4C').rank).to eq(:four)
      expect(Poker::Card.new('5C').rank).to eq(:five)
      expect(Poker::Card.new('6C').rank).to eq(:six)
      expect(Poker::Card.new('7C').rank).to eq(:seven)
      expect(Poker::Card.new('8C').rank).to eq(:eight)
      expect(Poker::Card.new('9C').rank).to eq(:nine)
      expect(Poker::Card.new('TC').rank).to eq(:ten)
      expect(Poker::Card.new('JC').rank).to eq(:jack)
      expect(Poker::Card.new('QC').rank).to eq(:queen)
      expect(Poker::Card.new('KC').rank).to eq(:king)
      expect(Poker::Card.new('AC').rank).to eq(:ace)
    end
  end

  describe '#suit' do
    it 'should be symbol represention of card suit' do
      expect(Poker::Card.new('2C').suit).to eq(:clubs)
      expect(Poker::Card.new('2D').suit).to eq(:diamonds)
      expect(Poker::Card.new('2H').suit).to eq(:hearts)
      expect(Poker::Card.new('2S').suit).to eq(:spades)
    end
  end
end