module Poker
  class Hand
    attr_reader :cards

    def initialize(cards)
      @cards = cards.map do |card|
        if card.is_a? Card
          card
        else
          Card.new(card)
        end
      end
    end

    def <=>(other)
      rank <=> other.rank
    end

    def rank
      @rank ||= Rank.new(cards)
    end
  end
end