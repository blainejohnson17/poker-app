require 'rails_helper'

describe Poker::Hand do
  describe '.new' do
    it 'returns new Poker::Hand' do
      cards = ['2D', '5H', 'KS'].map { |code| Poker::Card.new(code) }
      hand = Poker::Hand.new(cards)

      expect(hand).to be_a(Poker::Hand)
      expect(hand.cards).to contain_exactly(*cards)
    end

    it 'handles card_codes as input' do
      card_codes = ['2D', '5H', 'KS']
      hand = Poker::Hand.new(card_codes)

      expect(hand).to be_a(Poker::Hand)
      expect(hand.cards).to contain_exactly(*card_codes.map { |code| Poker::Card.new(code) })
    end
  end

  describe '#rank' do
    it 'should return rank' do
      cards = [
        Poker::Card.new('2D'),
        Poker::Card.new('2D'),
        Poker::Card.new('2D'),
        Poker::Card.new('5H'),
        Poker::Card.new('7S')
      ]

      rank = Poker::Hand.new(cards).rank
      expect(rank).to be_a(Poker::Rank)
      expect(rank.cards).to contain_exactly(*cards)
    end
  end
end