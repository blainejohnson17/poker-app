module Poker
  class Card
    attr_reader :value, :rank, :suit
    
    RANK_ORDER = %w[2 3 4 5 6 7 8 9 T J Q K A].freeze
    RANK_CODE_MAP = {
      '2' => :two,
      '3' => :three,
      '4' => :four,
      '5' => :five,
      '6' => :six,
      '7' => :seven,
      '8' => :eight,
      '9' => :nine,
      'T' => :ten,
      'J' => :jack,
      'Q' => :queen,
      'K' => :king,
      'A' => :ace
    }.freeze
    SUIT_CODE_MAPS = {
      'C' => :clubs,
      'D' => :diamonds,
      'H' => :hearts,
      'S' => :spades
    }.freeze

    def initialize(code)
      @value, @rank, @suit = parse_code(code)
    end

    def ==(other)
      [rank, suit] == [other.rank, other.suit]
    end

    private

    def parse_code(code)
      rank_code, suit_code = code.split('')
      value = RANK_ORDER.find_index(rank_code)
      rank = RANK_CODE_MAP[rank_code]
      suit = SUIT_CODE_MAPS[suit_code]
      [value, rank, suit]
    end
  end
end