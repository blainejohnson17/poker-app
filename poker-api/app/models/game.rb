class Game < ApplicationRecord
  has_many :hands
  
  before_save :update_winner

  def update_winner
    winning_hand = hands.max_by { |hand| hand.rank }
    if winning_hand
      winning_hand.update(winner: true)
    end
  end
end
