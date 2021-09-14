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
    let(:royal_flush) { build_rank(%w[TC JC QC KC AC]) }
    let(:straight_flush) { build_rank(%w[9C TC JC QC KC]) }
    let(:four_of_a_kind) { build_rank(%w[5C 5D 5H 5S 9S]) }
    let(:full_house) { build_rank(%w[4H 4S 4D 9C 9D]) }
    let(:flush) { build_rank(%w[3H 4H 9H QH AH]) }
    let(:straight) { build_rank(%w[9H TC JD QS KH]) }
    let(:three_of_a_kind) { build_rank(%w[5C 5D 5H 9C KH]) }
    let(:two_pairs) { build_rank(%w[5C 5D 9H 9C KH]) }
    let(:one_pair) { build_rank(%w[5C 5D 7H 9C KH]) }
    let(:high_card) { build_rank(%w[2C 5D AH 9C KH]) }

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
        rank1 = build_rank(%w[2C 5D AH 9C KH])
        rank2 = build_rank(%w[2C 5D QH 9C KH])
        expect([rank1, rank2].max).to eq(rank1)
      end

      it 'sorts one_pair hands' do
        rank1 = build_rank(%w[6C 6D 7H 9C KH])
        rank2 = build_rank(%w[5C 5D 7H 9C KH])
        expect([rank1, rank2].max).to eq(rank1)

        rank1 = build_rank(%w[5C 5D 7H 9C AH])
        rank2 = build_rank(%w[5C 5D 7H 9C KH])
        expect([rank1, rank2].max).to eq(rank1)

        rank1 = build_rank(%w[5C 5D 7H TC KH])
        rank2 = build_rank(%w[5C 5D 7H 9C KH])
        expect([rank1, rank2].max).to eq(rank1)

        rank1 = build_rank(%w[5C 5D 8H 9C KH])
        rank2 = build_rank(%w[5C 5D 7H 9C KH])
        expect([rank1, rank2].max).to eq(rank1)
      end

      it 'sorts two_pairs hands' do
        rank1 = build_rank(%w[5C 5D TH TC KH])
        rank2 = build_rank(%w[5C 5D 9H 9C KH])
        expect([rank1, rank2].max).to eq(rank1)

        rank1 = build_rank(%w[6C 6D 9H 9C KH])
        rank2 = build_rank(%w[5C 5D 9H 9C KH])
        expect([rank1, rank2].max).to eq(rank1)

        rank1 = build_rank(%w[5C 5D 9H 9C AH])
        rank2 = build_rank(%w[5C 5D 9H 9C KH])
        expect([rank1, rank2].max).to eq(rank1)
      end

      it 'sorts three_of_a_kind hands' do
        rank1 = build_rank(%w[6C 6D 6H 9C KH])
        rank2 = build_rank(%w[5C 5D 5H 9C KH])
        expect([rank1, rank2].max).to eq(rank1)

        rank1 = build_rank(%w[5C 5D 5H 9C AH])
        rank2 = build_rank(%w[5C 5D 5H 9C KH])
        expect([rank1, rank2].max).to eq(rank1)

        rank1 = build_rank(%w[5C 5D 5H TC KH])
        rank2 = build_rank(%w[5C 5D 5H 9C KH])
        expect([rank1, rank2].max).to eq(rank1)
      end

      it 'sorts straight hands' do
        rank1 = build_rank(%w[TC JD QS KH AH])
        rank2 = build_rank(%w[9H TC JD QS KH])
        expect([rank1, rank2].max).to eq(rank1)
      end

      it 'sorts flush hands' do
        rank1 = build_rank(%w[3H 4H 9H QH AH])
        rank2 = build_rank(%w[3H 4H 9H QH KH])
        expect([rank1, rank2].max).to eq(rank1)

        rank1 = build_rank(%w[3H 4H 9H KH AH])
        rank2 = build_rank(%w[3H 4H 9H QH AH])
        expect([rank1, rank2].max).to eq(rank1)

        rank1 = build_rank(%w[3H 4H TH QH AH])
        rank2 = build_rank(%w[3H 4H 9H QH AH])
        expect([rank1, rank2].max).to eq(rank1)

        rank1 = build_rank(%w[3H 4H TH QH AH])
        rank2 = build_rank(%w[3H 4H 9H QH AH])
        expect([rank1, rank2].max).to eq(rank1)

        rank1 = build_rank(%w[3H 5H 9H QH AH])
        rank2 = build_rank(%w[3H 4H 9H QH AH])
        expect([rank1, rank2].max).to eq(rank1)

        rank1 = build_rank(%w[4H 4H 9H QH AH])
        rank2 = build_rank(%w[3H 4H 9H QH AH])
        expect([rank1, rank2].max).to eq(rank1)
      end

      it 'sorts full_house hands' do
        rank1 = build_rank(%w[4H 4S 4D TC TD])
        rank2 = build_rank(%w[4H 4S 4D 9C 9D])
        expect([rank1, rank2].max).to eq(rank1)

        rank1 = build_rank(%w[5H 5S 5D 9C 9D])
        rank2 = build_rank(%w[4H 4S 4D 9C 9D])
        expect([rank1, rank2].max).to eq(rank1)

        rank1 = build_rank(%w[5H 5S 5D TC TD])
        rank2 = build_rank(%w[4H 4S 4D 9C 9D])
        expect([rank1, rank2].max).to eq(rank1)
      end

      it 'sorts four_of_a_kind hands' do
        rank1 = build_rank(%w[6C 6D 6H 6S 9S])
        rank2 = build_rank(%w[5C 5D 5H 5S 9S])
        expect([rank1, rank2].max).to eq(rank1)

        rank1 = build_rank(%w[5C 5D 5H 5S TS])
        rank2 = build_rank(%w[5C 5D 5H 5S 9S])
        expect([rank1, rank2].max).to eq(rank1)
      end

      it 'sorts straight_flush hands' do
        rank1 = build_rank(%w[9C TC JC QC KC])
        rank2 = build_rank(%w[8C 9C TC JC QC])
        expect([rank1, rank2].max).to eq(rank1)
      end

      it 'sorts royal_flush hands' do
        # 2 royal flushes are same rank so either are valid as max
        rank1 = build_rank(%w[TC JC QC KC AC])
        rank2 = build_rank(%w[TC JC QC KC AC])
        expect([rank1, rank2]).to include([rank1, rank2].max)
      end
    end
  end

  def build_rank(card_codes)
    Poker::Rank.new(card_codes.map { |c| Poker::Card.new(c) })
  end
end
