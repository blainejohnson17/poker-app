module Poker
  class Rank
    include RankType
    attr_reader :cards

    RANKS_LOW_TO_HIGH = [
      :high_card,
      :one_pair,
      :two_pairs,
      :three_of_a_kind,
      :straight,
      :flush,
      :full_house,
      :four_of_a_kind,
      :straight_flush,
      :royal_flush
    ].freeze
    RANKS_HIGH_TO_LOW = RANKS_LOW_TO_HIGH.reverse.freeze

    def initialize(cards)
      @cards = cards
    end

    def <=>(other)
      if type == other.type
        type_value <=> other.type_value
      else
        value <=> other.value
      end
    end

    def type
      @type ||= RANKS_HIGH_TO_LOW.detect { |rank_type| send(rank_type) }
    end

    protected

    def type_value
      @type_value ||= send(type)
    end

    def value
      @value ||= RANKS_LOW_TO_HIGH.find_index(type)
    end
  end
end