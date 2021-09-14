require 'rails_helper'

describe Poker::Rank do
  describe '#cards' do
    it 'returns cards passed in during initialization' do
      cards = %w[2D 2D 2D 5H 7S].map{ |c| Poker::Card.new(c) }
      rank = Poker::Rank.new(cards)
      expect(rank.cards).to contain_exactly(*cards)
    end
  end
  
  describe '#type' do
    it 'detects royal flush' do
      cards = %w[TC JC QC KC AC].map{ |c| Poker::Card.new(c) }
      rank = Poker::Rank.new(cards)
      expect(rank.type).to eq(:royal_flush)
    end

    it 'detects straight flush' do
      cards = %w[9C TC JC QC KC].map{ |c| Poker::Card.new(c) }
      rank = Poker::Rank.new(cards)
      expect(rank.type).to eq(:straight_flush)
    end

    it 'detects four of a kind' do
      cards = %w[5C 5D 5H 5S 9S].map{ |c| Poker::Card.new(c) }
      rank = Poker::Rank.new(cards)
      expect(rank.type).to eq(:four_of_a_kind)
    end

    it 'detects full house' do
      cards = %w[4H 4S 4D 9C 9D].map{ |c| Poker::Card.new(c) }
      rank = Poker::Rank.new(cards)
      expect(rank.type).to eq(:full_house)
    end

    it 'detects flush' do
      cards = %w[3H 4H 9H QH AH].map{ |c| Poker::Card.new(c) }
      rank = Poker::Rank.new(cards)
      expect(rank.type).to eq(:flush)
    end

    it 'detects straight' do
      cards = %w[9H TC JD QS KH].map{ |c| Poker::Card.new(c) }
      rank = Poker::Rank.new(cards)
      expect(rank.type).to eq(:straight)
    end

    it 'detects three of a kind' do 
      cards = %w[5C 5D 5H 9C KH].map{ |c| Poker::Card.new(c) }
      rank = Poker::Rank.new(cards)
      expect(rank.type).to eq(:three_of_a_kind)
    end

    it 'detects two pair' do
      cards = %w[5C 5D 9H 9C KH].map{ |c| Poker::Card.new(c) }
      rank = Poker::Rank.new(cards)
      expect(rank.type).to eq(:two_pairs)
    end

    it 'detects one pair' do
      cards = %w[5C 5D 7H 9C KH].map{ |c| Poker::Card.new(c) }
      rank = Poker::Rank.new(cards)
      expect(rank.type).to eq(:one_pair)
    end

    it 'detects high card' do
      cards = %w[2C 5D AH 9C KH].map{ |c| Poker::Card.new(c) }
      rank = Poker::Rank.new(cards)
      expect(rank.type).to eq(:high_card)
    end
  end

  describe '#<=>' do
    let(:royal_flush) { Poker::Rank.new(%w[TC JC QC KC AC].map{ |c| Poker::Card.new(c) }) }
    let(:straight_flush) { Poker::Rank.new(%w[9C TC JC QC KC].map{ |c| Poker::Card.new(c) }) }
    let(:four_of_a_kind) { Poker::Rank.new(%w[5C 5D 5H 5S 9S].map{ |c| Poker::Card.new(c) }) }
    let(:full_house) { Poker::Rank.new(%w[4H 4S 4D 9C 9D].map{ |c| Poker::Card.new(c) }) }
    let(:flush) { Poker::Rank.new(%w[3H 4H 9H QH AH].map{ |c| Poker::Card.new(c) }) }
    let(:straight) { Poker::Rank.new(%w[9H TC JD QS KH].map{ |c| Poker::Card.new(c) }) }
    let(:three_of_a_kind) { Poker::Rank.new(%w[5C 5D 5H 9C KH].map{ |c| Poker::Card.new(c) }) }
    let(:two_pairs) { Poker::Rank.new(%w[5C 5D 9H 9C KH].map{ |c| Poker::Card.new(c) }) }
    let(:one_pair) { Poker::Rank.new(%w[5C 5D 7H 9C KH].map{ |c| Poker::Card.new(c) }) }
    let(:high_card) { Poker::Rank.new(%w[2C 5D AH 9C KH].map{ |c| Poker::Card.new(c) }) }

    context 'compare different ranks' do
      it 'sorts based on rank type' do
        ranks_low_to_high = [
          high_card,
          one_pair,
          two_pairs,
          three_of_a_kind,
          straight,
          flush,
          full_house,
          four_of_a_kind,
          straight_flush,
          royal_flush
        ]
        ranks_in_random_order = ranks_low_to_high.shuffle
        expect(ranks_in_random_order.sort).to eq(ranks_low_to_high)
      end
    end

    context 'compare same rank' do
      it 'sorts high_card hands' do
        high_card_hand1 = Poker::Rank.new(%w[2C 5D AH 9C KH].map{ |c| Poker::Card.new(c) })
        high_card_hand2 = Poker::Rank.new(%w[2C 5D QH 9C KH].map{ |c| Poker::Card.new(c) })
        expect([high_card_hand1, high_card_hand2].max).to eq(high_card_hand1)
      end
    end
  end
end