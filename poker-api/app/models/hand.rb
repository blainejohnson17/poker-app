class Hand < ApplicationRecord
  belongs_to :game
  belongs_to :player

  after_save :update_counter_cache
  after_destroy :update_counter_cache

  extend ArrayEnum

  array_enum card_codes: {
    "2C"=>1, "2D"=>2, "2H"=>3, "2S"=>4, "3C"=>5, "3D"=>6, "3H"=>7, "3S"=>8,
    "4C"=>9, "4D"=>10, "4H"=>11, "4S"=>12, "5C"=>13, "5D"=>14, "5H"=>15,
    "5S"=>16, "6C"=>17, "6D"=>18, "6H"=>19, "6S"=>20, "7C"=>21, "7D"=>22,
    "7H"=>23, "7S"=>24, "8C"=>25, "8D"=>26, "8H"=>27, "8S"=>28, "9C"=>29,
    "9D"=>30, "9H"=>31, "9S"=>32, "TC"=>33, "TD"=>34, "TH"=>35, "TS"=>36,
    "JC"=>37, "JD"=>38, "JH"=>39, "JS"=>40, "QC"=>41, "QD"=>42, "QH"=>43,
    "QS"=>44, "KC"=>45, "KD"=>46, "KH"=>47, "KS"=>48, "AC"=>49, "AD"=>50,
    "AH"=>51, "AS"=>52
  }

  def rank
    Poker::Hand.new(card_codes).rank
  end

  def update_counter_cache
    self.player.update_column(:winning_hands, Hand.where(player: player, winner: true).count)
  end
end
