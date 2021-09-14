module Types
  class PlayerType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :winning_hands, Integer, null: false
  end
end
