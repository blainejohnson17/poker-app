module Types
  class HandType < Types::BaseObject
    field :id, ID, null: false
    field :player_id, Integer, null: true
    field :game_id, Integer, null: true
    field :card_codes, [String], null: false
    field :winner, Boolean, null: false
  end
end
