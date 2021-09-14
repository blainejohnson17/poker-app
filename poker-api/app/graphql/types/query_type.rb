module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :games,
          [Types::GameType],
          null: false,
          description: "Returns a list of games"

    field :players,
          [Types::PlayerType],
          null: false,
          description: "Returns a list of players"

    def games
      Game.all
    end

    def players
      Player.all
    end
  end
end
