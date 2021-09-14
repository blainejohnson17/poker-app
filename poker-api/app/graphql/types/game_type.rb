module Types
  class GameType < Types::BaseObject
    field :id, ID, null: false
    field :hands, [Types::HandType], null: false

    def hands
      Loaders::HasManyLoader.for(Hand, :game_id).load(object.id)
    end
  end
end
