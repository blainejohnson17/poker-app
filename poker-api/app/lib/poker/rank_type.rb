module Poker
  module RankType
    def flush
      if cards.map(&:suit).uniq.size == 1
        card_values.sort.reverse
      end
    end

    def four_of_a_kind
      rank_value = card_values.detect { |value| card_values.count(value) >= 4 }
      if rank_value
        non_rank_values = card_values - [rank_value]
        [rank_value, *non_rank_values.sort.reverse]
      end
    end

    def full_house
      three_of_kind_value = card_values.detect { |value| card_values.count(value) >= 3 }

      if three_of_kind_value
        rest_card_values = card_values - [three_of_kind_value]
        two_of_kind_value = rest_card_values.detect { |value| card_values.count(value) >= 2 }
        if three_of_kind_value && two_of_kind_value
          [three_of_kind_value, two_of_kind_value].sort.reverse
        end
      end
    end

    def high_card
      card_values.max
    end

    def one_pair
      rank_value = card_values.detect { |value| card_values.count(value) >= 2 }
      if rank_value
        non_rank_values = card_values - [rank_value]
        [rank_value, *non_rank_values.sort.reverse]
      end
    end

    def royal_flush
      all_same_suit = cards.map(&:suit).uniq.size == 1
      if all_same_suit
        includes_ten_through_ace = [:ten, :jack, :queen, :king, :ace].all? do |rank|
          cards.any? { |card| card.rank == rank }
        end
      end
    end

    def straight
      sorted_card_values = card_values.sort
      if sorted_card_values.each_cons(2).all? {|a, b| b == a + 1 }
        sorted_card_values[-1]
      end
    end

    def straight_flush
      all_same_suit = cards.map(&:suit).uniq.size == 1
      all_same_suit && straight
    end

    def three_of_a_kind
      rank_value = card_values.detect { |value| card_values.count(value) >= 3 }
      if rank_value
        non_rank_values = card_values - [rank_value]
        [rank_value, *non_rank_values.sort.reverse]
      end
    end

    def two_pairs
      rank_values = card_values.select { |value| card_values.count(value) >= 2 }.uniq

      if rank_values.size >= 2
        non_rank_values = card_values - rank_values
        [*rank_values.sort.reverse, *non_rank_values.sort.reverse]
      end
    end


    private

    def card_values
      @card_values ||= cards.map(&:value)
    end
  end
end