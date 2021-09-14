require 'rails_helper'

describe Hand, type: :model do
  describe 'relationships' do
    it { should belong_to(:game) }
    it { should belong_to(:player) }
  end

  describe '#rank' do
    it 'returns Poker::Rank' do
      card_codes = %w[TC JC QC KC AC]
      rank = Hand.new(card_codes: card_codes).rank
      expect(rank).to be_a(Poker::Rank)
      expect(rank.cards).to contain_exactly(*card_codes.map {|c| Poker::Card.new(c)})
    end
  end
end